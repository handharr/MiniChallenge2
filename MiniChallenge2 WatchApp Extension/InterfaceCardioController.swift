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
    
    var delegate : RunningSessionDelegate?
    var isRunning : Bool = true
    var session : WCSession = WCSession.default
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
            
        let scene = SKScene(size: CGSize(width: 120, height: 120))
        scene.scaleMode = .aspectFit
        scene.scene?.backgroundColor = .clear
        interfaceScene.presentScene(scene)


        let fraction: CGFloat = 1.3/1.6
        let data = -CGFloat.pi * 2 * fraction

        let data2 = CGFloat.pi/2
        let path = UIBezierPath(arcCenter: .zero,
                                 radius: 50,
                                 startAngle: data2,
                                 endAngle: data + data2,
                                 clockwise: false).cgPath
        let backgroundPath = UIBezierPath(arcCenter: .zero,
                                 radius: 50,
                                 startAngle: 0,
                                 endAngle: CGFloat.pi * 2,
                                 clockwise: false).cgPath


        let shapeNode = SKShapeNode(path: path)
        let backgroundNode = SKShapeNode(path: backgroundPath)

        backgroundNode.strokeColor = UIColor(red: 52/255, green: 52/255, blue: 52/255, alpha: 1)
        backgroundNode.fillColor = .clear
        backgroundNode.lineWidth = 12
        backgroundNode.lineCap = .round
        backgroundNode.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)

        shapeNode.strokeColor = .sweetBrown
        shapeNode.lineWidth = 12
        shapeNode.lineCap = .round
        shapeNode.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)

        scene.addChild(backgroundNode)
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
    }

    @IBAction func pauseTapped() { 
        if isRunning {
            DispatchQueue.main.async {
                self.pausePlayButton.setBackgroundImageNamed("playbutto3")
            }
        } else {
            DispatchQueue.main.async {
//                self.pausePlayButton.setBackgroundImage(#imageLiteral(resourceName: "playbutto3"))
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
