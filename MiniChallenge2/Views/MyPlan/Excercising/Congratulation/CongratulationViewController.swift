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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let subView:CongratulationMessageView = CongratulationMessageView(frame: CGRect(x: 52, y: 450, width: 310, height: 240))
        self.view.addSubview(subView)
        
        doneButton.layer.cornerRadius = 8

    }

}
