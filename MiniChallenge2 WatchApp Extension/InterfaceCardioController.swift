//
//  InterfaceCardioController.swift
//  MiniChallenge2 WatchApp Extension
//
//  Created by Jackie Leonardy on 15/06/21.
//

import WatchKit
import SpriteKit
import WatchConnectivity

class InterfaceCardioController: WKInterfaceController{
    @IBOutlet weak var interfaceScene: WKInterfaceSKScene!
    @IBOutlet weak var pausePlayButton: WKInterfaceButton!
    @IBOutlet weak var distanceLabel: WKInterfaceLabel!
    
    let scene = SKScene(size: CGSize(width: 120, height: 120))
    var delegate : RunningSessionDelegate?
    var isRunning : Bool = true
    var session : WCSession = WCSession.default
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setUpData()
        setUpNotification()
        setTitle("")
    }
        
    func setUpNotification(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "runningDistance"), object: nil, queue: OperationQueue.main) { (notification) in
            let workoutVC = notification.object as! WorkoutSessionInterfaceController
            
            self.scene.removeAllChildren()
            
            let fraction: CGFloat = CGFloat(workoutVC.distance/1.6)
            let data = -CGFloat.pi * 2 * fraction
            let data2 = CGFloat.pi/2
            let path = UIBezierPath(arcCenter: .zero,
                                     radius: 50,
                                     startAngle: data2,
                                     endAngle: data + data2,
                                     clockwise: false).cgPath
            let newShapeNode = SKShapeNode(path: path)
            newShapeNode.strokeColor = .sweetBrown
            newShapeNode.lineWidth = 12
            newShapeNode.lineCap = .round
            newShapeNode.position = CGPoint(x: self.scene.size.width / 2, y: self.scene.size.height / 2)
            newShapeNode.name = "circularProgress"
            self.scene.addChild(newShapeNode)
            self.distanceLabel.setText(String(format: "%.2f", workoutVC.distance))
        }
    }
    
    func setUpData(){
        scene.scaleMode = .aspectFit
        scene.scene?.backgroundColor = .clear
        interfaceScene.presentScene(scene)


        let fraction: CGFloat = 0/1.6
        let data = -CGFloat.pi * 2 * fraction

        let data2 = CGFloat.pi/2
        let path = UIBezierPath(arcCenter: .zero,
                                 radius: 50,
                                 startAngle: data2,
                                 endAngle: data + data2,
                                 clockwise: false).cgPath

        let shapeNode = SKShapeNode(path: path)
        shapeNode.strokeColor = .sweetBrown
        shapeNode.lineWidth = 12
        shapeNode.lineCap = .round
        shapeNode.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
        shapeNode.name = "circularProgress"

        scene.addChild(shapeNode)
    }
    
    @IBAction func skippedTapped() {
        let data = ["skipped" : "\(UUID())"]
        do{
            try self.session.updateApplicationContext(data)
        }catch{ }
        NotificationCenter.default.post(name: NSNotification.Name("Skip Triggered"), object: nil)
        self.dismiss()
    }
    
    override func willActivate() {
        super.willActivate()
        session.delegate = self
        session.activate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        scene.removeFromParent()
    }

    @IBAction func pauseTapped() { 
        if isRunning {
            DispatchQueue.main.async {
                self.pausePlayButton.setBackgroundImageNamed("playbutto3")
            }
        } else {
            DispatchQueue.main.async {
                self.pausePlayButton.setBackgroundImageNamed("pausebutton3")
            }
        }
        isRunning = !isRunning

        NotificationCenter.default.post(name: NSNotification.Name("Pause Triggered"), object: nil)
    }
}

extension InterfaceCardioController: WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let receivedData = applicationContext["quit"] as? String{
            self.dismiss()
            print(receivedData)
        }
    }
    
}
