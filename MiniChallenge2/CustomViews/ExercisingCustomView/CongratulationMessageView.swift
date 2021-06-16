//
//  CongratulationMessageView.swift
//  XibTutorial
//
//  Created by Bayu Triharyanto on 11/06/21.
//

import UIKit

class CongratulationMessageView: UIView {

    @IBOutlet weak var completeLabel: UILabel!
    @IBOutlet weak var planTitleLabel: UILabel!
    @IBOutlet weak var dayExerciseLabel: UILabel!
    @IBOutlet weak var inLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    
    var view:UIView!
    var timeString = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        timeLabel?.text = timeString
    }
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
    func commonInit(){
        let viewXib = Bundle.main.loadNibNamed("CongratulationMessageView", owner: self, options: nil)! [0] as! UIView
        viewXib.frame = self.bounds
        addSubview(viewXib)
//        timeLabel.text = timeString
    }
    
    func setUpView(){
        planTitleLabel?.text = ""
        timeLabel?.text = timeString
    }
}
