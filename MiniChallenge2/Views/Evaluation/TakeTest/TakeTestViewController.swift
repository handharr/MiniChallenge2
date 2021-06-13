//
//  TakeTestViewController.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 03/06/21.
//

import UIKit
import WatchConnectivity

class TakeTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let supported = WCSession.isSupported() else { }
        
        let session = WCSession.default
        session.delegate = self
        session.activate() // activate the session

        if session.paired {
            
        }
    }
}

extension TakeTestViewController: WCSessionDelegate{
    func sessionDidDeactivate(_ session: WCSession) {
    
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //yang pertama direach
    }
}
