//
//  ExamCameraViewViewController.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 14/06/21.
//

import UIKit
import AVFoundation

class ExamCameraViewViewController: UIViewController {
    
    private let videoCapture = VideoCapture()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var overlayLayer = CAShapeLayer()
    private var pointsPath = UIBezierPath()
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var rightLabelContainer: UIView!
    @IBOutlet weak var leftLabelContainer: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightLabelContainer.layer.cornerRadius = 8
        leftLabelContainer.layer.cornerRadius = 8

        setupVideoPreview()
    }
}

// MARK: - View Lifecycle

extension ExamCameraViewViewController {
    override func viewDidLayoutSubviews() {
        
        guard let connection =  self.previewLayer?.connection else {return}
        
        let orientation: UIDeviceOrientation = UIDevice.current.orientation
        
        if connection.isVideoOrientationSupported {
            
            switch (orientation) {
            case .portrait: updatePreviewLayer(layer: connection, orientation: .portrait)
                
            case .landscapeRight: updatePreviewLayer(layer: connection, orientation: .landscapeLeft)
                
            case .landscapeLeft: updatePreviewLayer(layer: connection, orientation: .landscapeRight)
                
            case .portraitUpsideDown: updatePreviewLayer(layer: connection, orientation: .portraitUpsideDown)
                
            default: updatePreviewLayer(layer: connection, orientation: .portrait)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Layouting
extension ExamCameraViewViewController {
    private func setupVideoPreview() {
        
        videoCapture.delegate = self
        
        // Do any additional setup after loading the view.
        videoCapture.startCapture()
        previewLayer = AVCaptureVideoPreviewLayer(session: videoCapture.captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
        
        guard let previewLayer = previewLayer else {
            return
        }
        
        cameraView.layer.addSublayer(previewLayer)
        previewLayer.frame = cameraView.bounds
        
        previewLayer.addSublayer(overlayLayer)
        overlayLayer.frame = previewLayer.bounds
    }
}

//MARK: - Helper Function
extension ExamCameraViewViewController {
    private func updatePreviewLayer(layer: AVCaptureConnection, orientation: AVCaptureVideoOrientation) {
        
        guard let previewLayer = previewLayer else {return}
        
        layer.videoOrientation = orientation
        
        previewLayer.frame = self.view.bounds
    }
}

// MARK: - Video Capture Delegate
extension ExamCameraViewViewController: VideoCaptureDelegate {
    
    func processPoints(_ points: [CGPoint]) {
        
        guard let previewLayer = previewLayer else { return }
        
        let pointsToDraw: [CGPoint] = points.compactMap {
            return previewLayer.layerPointConverted(fromCaptureDevicePoint: $0)
        }

        pointsPath.removeAllPoints()
        
        for point in pointsToDraw {
            pointsPath.move(to: point)
            pointsPath.addArc(withCenter: point, radius: 5, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        }
        
        overlayLayer.fillColor = UIColor.red.cgColor
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        overlayLayer.path = pointsPath.cgPath
        CATransaction.commit()
    }
}
