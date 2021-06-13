//
//  InterfaceController.swift
//  MiniChallenge2Watch WatchKit Extension
//
//  Created by Jackie Leonardy on 12/06/21.
//

import WatchKit
import Foundation
import SpriteKit
import WatchConnectivity

protocol RunningSessionDelegate {
    func stopDidTapped(isRunning : Bool)
    func workoutDidCancel()
}


class InterfaceController: WKInterfaceController {
    
    
    
    @IBOutlet weak var interfaceScene: WKInterfaceSKScene!
    
    var delegate : RunningSessionDelegate?
    var isRunning : Bool = false
    
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
        print("firstScene")

    }
    
    @IBAction func skippedTapped() {
//        self.popToRootController()
        delegate?.workoutDidCancel()
    }
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }

    @IBAction func pauseTapped() {
//        self.popToRootController()
        delegate?.stopDidTapped(isRunning: self.isRunning)
        isRunning = !isRunning
    }
}
