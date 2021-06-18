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
    private var timer: Timer!
    private var startView: StrengthTestLayerStart!
    private var timerCounter = 10 {
        didSet {
            handletimerOut()
        }
    }
    private var counter = 0 {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.countLabel.text = "\(self.counter)"
            }
        }
    }
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var rightLabelContainer: UIView!
    @IBOutlet weak var leftLabelContainer: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightLabelContainer.layer.cornerRadius = 8
        leftLabelContainer.layer.cornerRadius = 8
        
        countLabel.text = "\(counter)"
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        videoCapture.endCapture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startView = StrengthTestLayerStart(frame: view.bounds)
        view.addSubview(startView)
        
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(handleStartTimer), userInfo: nil, repeats: false)
        
        setupVideoPreview()
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
    
    @objc private func handleStartTimer() {
        startView.removeFromSuperview()
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(handleCountDown), userInfo: nil, repeats: true)
    }
    
    @objc private func handleCancelButton() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func handleCountDown() {
        timerCounter -= 1
    }
    
    private func handletimerOut() {
        let sec = String(format: "%02d", timerCounter)
        timerLabel.text = "00:\(sec)"
        
        if timerCounter == 0 {
            timer.invalidate()
            self.videoCapture.endCapture()
            
            let someView = StrengthTestLayerResult(frame: self.view.bounds)
            someView.delegate = self
            someView.primaryLabel.text = "\(self.counter)"
            self.view.addSubview(someView)
        }
    }
}

// MARK: - Video Capture Delegate
extension ExamCameraViewViewController: VideoCaptureDelegate {
    
    func processPrediction() {
        counter += 1
    }
    
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

// MARK: - ResultView Delegate
extension ExamCameraViewViewController: StrengthTestLayerResultDelegate {
    func handleIncorrectTapped() {
        let vc = InputCountExamViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleDoneTapped() {
        let vc = StrengthTestResultViewController()
        vc.pushUPCount = counter
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleCancelTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}
