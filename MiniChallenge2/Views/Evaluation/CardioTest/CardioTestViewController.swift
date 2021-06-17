//
//  CardioTestViewController.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 03/06/21.
//

import UIKit
import CoreMotion
import WatchConnectivity

class CardioTestViewController: UIViewController, CardioTestDelegate {
    
    let ringShape = CAShapeLayer()
    var circlePath: UIBezierPath?
    var labelView: CardioCircleLabel?
    var point: CGPoint?
    
    var isUsingPhone: Bool?
    var takeTest = TakeTestViewController()
    
    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    
    var watchSession: WCSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        takeTest.delegate = self
        
        let closeIcon = UIImage(systemName: "xmark")!
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: closeIcon,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(handleCancelButton))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        point = CGPoint(x: view.center.x, y: view.center.y)
        
        print(view.center.y)
        
        guard let point = point else {return}
        
        circlePath = UIBezierPath(arcCenter: point,
                                  radius: (view.frame.width - 100)/2,
                                  startAngle: -(.pi / 2),
                                  endAngle: .pi * 2,
                                  clockwise: true)
        
        setupRingShape()
        setupLabelView()
        if self.isUsingPhone!{
            setUpPedoMeter()
        }
        
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
    }
    
    func setUpPedoMeter(){
        self.labelView?.topLabel.text = "0,0"
        if CMMotionActivityManager.isActivityAvailable(){
            self.activityManager.startActivityUpdates(to: OperationQueue.main) { (data) in
                DispatchQueue.main.async {
                    if let activity = data {
                        if activity.running == true{
                            
                        }
                        else if activity.walking == true{
                        }
                        else if activity.automotive == true{
                        }
                    }
                }
            }
        }
        
        if CMPedometer.isStepCountingAvailable(){
            self.pedometer.startUpdates(from: Date()) { (data, error) in
                if error == nil{
                    if let response = data{
                        guard let pedometerDistance = response.distance else {return}
                        
                        let distanceInKilo = Measurement(value: pedometerDistance.doubleValue, unit: UnitLength.meters)

                        let distance = distanceInKilo.converted(to: UnitLength.kilometers)
                        
                        DispatchQueue.main.async {
                            self.labelView?.topLabel.text = "\(distance)"
                        }
                    }
                }
            }
        }
    }
    
    func setObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(isPhoneChosen(_:)), name: NSNotification.Name("Chosing Phone Notification"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(isPhoneChosen(_:)), name: NSNotification.Name("Chosing Phone Notification"), object: nil)
    }
    
    func phoneDidChosen(didPhoneChosen: Bool) {
        self.isUsingPhone = didPhoneChosen
    }
    
    @objc
    func isPhoneChosen(_ notification: NSNotification){
        if let dict = notification.userInfo as NSDictionary? {
            if let usingPhone = dict["isUsingPhone"] as? Bool{
                self.isUsingPhone = usingPhone
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Layout View
extension CardioTestViewController {
    
    private func setupLabelView() {
        guard let point = point else {return}
        
        labelView = CardioCircleLabel(frame: .init(x: point.x,
                                                       y: point.y,
                                                       width: view.frame.width - 24,
                                                       height: 143))
        
        guard let labelView = labelView else {return}
        
        labelView.center = point
        view.addSubview(labelView)
    }
    
    private func setupRingShape() {
        guard let circlePath = circlePath else {
            return
        }
        
        let trackShape = CAShapeLayer()
        trackShape.path = circlePath.cgPath
        trackShape.lineWidth = 15
        trackShape.strokeColor = UIColor.lightGray.cgColor
        trackShape.fillColor = MCColor.MCCircleFillColor.cgColor
        view.layer.addSublayer(trackShape)
        
        ringShape.path = circlePath.cgPath
        ringShape.lineWidth = 15
        ringShape.strokeColor = MCColor.MCCircleStrokeColor.cgColor
        ringShape.fillColor = UIColor.clear.cgColor
        ringShape.strokeEnd = 1
        view.layer.addSublayer(ringShape)
    }
}

// MARK: - Events
extension CardioTestViewController {
    @objc private func handleCancelButton() {
        let ac = UIAlertController(title: nil,
                                   message: "Are you sure you want to quit the exam?",
                                   preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Quit", style: .destructive, handler: { [weak self] ac in
            guard self != nil else {return}
            let data = ["quit" : "\(UUID())"]
            do{
                try self?.watchSession?.updateApplicationContext(data)
            }catch{
                
            }
            self?.navigationController?.popToRootViewController(animated: true)
        }))
        ac.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
}

extension CardioTestViewController: WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        DispatchQueue.main.async {
            self.labelView?.topLabel.text = String(format: "%.1f", applicationContext["runningDistance"] as! Double)
//            self.timerLabel.text = "\(applicationContext["workoutTimer"] as! String)"
//            self.heartRate.text = String(format: "%.1f", applicationContext["heartRate"] as! Double)
        }
    }
}
