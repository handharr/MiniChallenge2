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
        self.workOutCriteria.text = "VO2 Max"
        self.excellentCriteria.text = "≥ 39"
        self.goodCriteria.text = "35 - 38"
        self.averageCriteria.text = "31 - 34"
        self.needWorkCriteria.text = "≤ 31"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellContainer.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
