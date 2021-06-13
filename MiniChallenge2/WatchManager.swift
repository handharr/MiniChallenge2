//
//  WatchManager.swift
//  MiniChallenge2
//
//  Created by Jackie Leonardy on 12/06/21.
//

import Foundation
import WatchConnectivity


class WatchManager: NSObject{
    static let shared: WatchManager = WatchManager()
    
    fileprivate var watchSession: WCSession?
    
    override init() {
        super.init()
        if(!WCSession.isSupported()){
//            WCSession = nil
            
            return
        }
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
    }
    
    func sendParamsToWatch(dict: [String: Any]){
        do{
            try watchSession?.updateApplicationContext(dict)
        } catch {
            print("error sendinr \(dict) to Apple Watch")
        }
    }
    
    /*
     WatchManager.shared.sendParamsToWatch(dict: [
        "aaa" : "aaa" ?? ""
        "bbbb" : "bbb" ?? ""
     ])
     
     
     
     */
}

extension WatchManager: WCSessionDelegate{
    func sessionDidDeactivate(_ session: WCSession) {
    
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //yang pertama direach
        print("Masuk 1")
    }
}
