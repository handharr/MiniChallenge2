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
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
    }
    
    override func didDeactivate() {
        print("geser")
    }
    
    override func willActivate() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            if session.isReachable {
              print("your iphone is Reachable")
            } else {
              print("your iphone is not Reachable...")
            }
          } else {
            print("This device is not supported.")
          }
    }
}

extension HomeInterfaceController: WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Watch Session Activation is Completed")
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        
        if let receivedData = applicationContext["data"] as? String{
            presentController(withNames: ["runningTest", "examCardio"], contexts: nil)
            print(receivedData)
        }
    }
}
