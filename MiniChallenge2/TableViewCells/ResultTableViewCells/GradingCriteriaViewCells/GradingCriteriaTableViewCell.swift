//
//  GradingCriteriaTableViewCell.swift
//  MiniChallenge2
//
//  Created by Jackie Leonardy on 09/06/21.
//

import UIKit

class GradingCriteriaTableViewCell: UITableViewCell {

    @IBOutlet weak var workOutCriteria: UILabel!
    @IBOutlet weak var excellentCriteria: UILabel!
    @IBOutlet weak var goodCriteria: UILabel!
    @IBOutlet weak var averageCriteria: UILabel!
    @IBOutlet weak var needWorkCriteria: UILabel!
    @IBOutlet weak var cellContainer: UIView!
    
    static func getIdentifier() -> String{
        return "gradingCriteriaTableViewCell"
    }
    
    static func getNib() -> UINib{
        return UINib(nibName: "\(GradingCriteriaTableViewCell.self)", bundle: nil)
    }
    
    func setData(){
        self.workOutCriteria.text = "Tricep Dip (2 Min)"
        self.excellentCriteria.text = "≥ 25"
        self.goodCriteria.text = "20 - 24"
        self.averageCriteria.text = "15 - 19"
        self.needWorkCriteria.text = "≤ 15"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellContainer.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
