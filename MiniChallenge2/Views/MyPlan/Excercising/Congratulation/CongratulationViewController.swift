//
//  CongratulationViewController.swift
//  XibTutorial
//
//  Created by Bayu Triharyanto on 11/06/21.
//

import UIKit

class CongratulationViewController: UIViewController {

    @IBOutlet weak var congratLabel: UILabel!
    @IBOutlet weak var congrateImage: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var congratulationMessageView: CongratulationMessageView!
    
    var timeString = ""
    lazy var messageView:CongratulationMessageView = {
        let subView = CongratulationMessageView(frame: CGRect(x: 40, y: 430, width: 310, height: 240))        
        subView.timeString = timeString
        return subView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        subView.timeString = timeString
        self.view.addSubview(messageView)
        doneButton.layer.cornerRadius = 8
        messageView.setUpView()

    }
    
    

}
