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
//        presentController(withNames: ["cardioExam", "runningTest"], contexts: nil)
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
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let data = applicationContext["data"] as? Bool {
            print(data)
            presentController(withNames: ["cardioExam", "runningTest"], contexts: nil)
        }
    }
    
//    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
//
//        return any
//    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
//        presentController(withNames: ["cardioExam", "runningTest"], contexts: nil)
    }
    
    
    
    
    
}
