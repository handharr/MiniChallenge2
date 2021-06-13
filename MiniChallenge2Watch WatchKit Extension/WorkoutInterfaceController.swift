//
//  WorkoutViewController.swift
//  MiniChallenge2Watch WatchKit Extension
//
//  Created by Jackie Leonardy on 12/06/21.
//

import WatchKit

class WorkoutInterfaceController: WKInterfaceController{
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.becomeCurrentPage()
        print("second secene")
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
}

