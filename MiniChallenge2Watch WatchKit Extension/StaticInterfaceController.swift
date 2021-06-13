//
//  StaticInterfaceController.swift
//  MiniChallenge2Watch WatchKit Extension
//
//  Created by Jackie Leonardy on 12/06/21.
//

import WatchKit
import Foundation
import WatchConnectivity

class StaticInterfaceController: WKInterfaceController {
        
    var watchSession : WCSession?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
    }
    @IBAction func next() {
        presentController(withNames: ["cardioExam", "runningTest"], contexts: nil)
    }
}

extension StaticInterfaceController: WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session Activation is Completed")
        let data : [String: Any] = ["BPM": "Message From Watch" as Any]
        watchSession!.sendMessage(data, replyHandler: nil, errorHandler: nil)
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        
    }
    
//    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
//
//        return any
//    }
    
    
    
}