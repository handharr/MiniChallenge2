//
//  HomeInterfaceController.swift
//  MiniChallenge2 WatchApp Extension
//
//  Created by Jackie Leonardy on 13/06/21.
//

import WatchKit
import Foundation
import WatchConnectivity

class HomeInterfaceController: WKInterfaceController {
        
    var watchSession : WCSession!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
//        presentController(withName: "cardioExam", context: nil)
    }
    
    override func didDeactivate() {
        print("geser")
    }
}

extension HomeInterfaceController: WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Watch Session Activation is Completed")
        let data : [String: Any] = ["BPM": "Message From Watch" as Any]
        watchSession!.sendMessage(data, replyHandler: nil, errorHandler: nil)
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        if let receivedData = userInfo["data"] as? String{
            presentController(withName: "lala", context: nil)
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let receivedData = applicationContext["data"] as? String{
//            presentController(withName: "lala", context: nil)
            presentController(withNames: ["runningTest", "examCardio"], contexts: nil)
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
    }

}
