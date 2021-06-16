//
//  VideoCapture.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 14/06/21.
//

import UIKit
import AVFoundation
import Vision
import CoreML

protocol VideoCaptureDelegate: NSObject {
    func processPoints(_ points: [CGPoint])
    func processPrediction()
}

class VideoCapture: NSObject {
    
    let captureSession = AVCaptureSession()
    let videoOutput = AVCaptureVideoDataOutput()
    let jointNames: [VNHumanBodyPoseObservation.JointName] = [
        .nose,
        .neck,
        .leftWrist,
        .leftElbow,
        .leftShoulder,
        .rightShoulder,
        .rightElbow,
        .rightWrist,
        .leftHip,
        .rightHip,
        .root,
        .leftAnkle,
        .rightAnkle,
        .leftKnee,
        .rightKnee
    ]
    
    var poseMultiArray: [MLMultiArray] = [] {
        didSet {
            handlePoseAdded()
        }
    }
    
    var points: [CGPoint] = []
    
    weak var delegate: VideoCaptureDelegate?
    
    override init() {
        super.init()
        
        guard let captureDevice = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: captureDevice) else {
            return
        }
        
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        captureSession.addInput(input)
        
        captureSession.addOutput(videoOutput)
        videoOutput.alwaysDiscardsLateVideoFrames = true
    }
    
    public func startCapture() {
        captureSession.startRunning()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoDispatchQueue"))
    }
}


// MARK: - AV Video Output Delegate

extension VideoCapture: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        defer {
          DispatchQueue.main.sync {
            delegate?.processPoints(points)
          }
        }
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        // Create a new image-request handler.
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])

        // Create a new request to recognize a human body pose.
        let request = VNDetectHumanBodyPoseRequest(completionHandler: handleBodyRequest)
        
        do {
            // Perform the body pose-detection request.
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the request: \(error).")
        }
    }
    
    private func handleBodyRequest(request: VNRequest, error: Error?) {
        
        guard let result = request.results as? [VNHumanBodyPoseObservation],
              let firstResult = result.first,
              let allPoints = try? firstResult.recognizedPoints(.all)
              else { return }
        
        guard let multiArr = try? firstResult.keypointsMultiArray() else { return }
        
        poseMultiArray.append(multiArr)
        
        points = jointNames.compactMap {
            guard let point = allPoints[$0], point.confidence > 0.3 else { return nil }
            
            return CGPoint(x: point.location.x, y: 1 - point.location.y)
        }
    }
    
    private func handlePoseAdded() {
        if poseMultiArray.count == 15 {
            let concatinateArr = MLMultiArray(concatenating: poseMultiArray, axis: 0, dataType: .float32)
            
            // CoreML
            do {
                let config = MLModelConfiguration()
                let model = try Pushup(configuration: config)

                let input = PushupInput(poses: concatinateArr)

                let outputPU = try model.prediction(input: input)

                let predLabel = outputPU.label

                if predLabel == "up" {
                    delegate?.processPrediction()
                }

                print("Hasil prediksi : \(outputPU.label)")
            } catch {
                print("error \(error)")
            }
            
            poseMultiArray.removeAll()
        }
    }
}
