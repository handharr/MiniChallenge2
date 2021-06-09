//
//  SummaryDetailPlanCollectionViewCell.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 08/06/21.
//

import UIKit

class SummaryDetailPlanCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SummaryDetailPlanCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SummaryDetailPlanCollectionViewCell", bundle: nil)
    }

    @IBOutlet weak var topMinutesLabel: UILabel!
    @IBOutlet weak var bottomMinutesLabel: UILabel!
    @IBOutlet weak var topSetLabel: UILabel!
    @IBOutlet weak var bottomSetLabel: UILabel!
    @IBOutlet weak var topExcercisesLabel: UILabel!
    @IBOutlet weak var bottomExcercisesLabel: UILabel!
    @IBOutlet weak var topLevelLabel: UILabel!
    @IBOutlet weak var bottomLevelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
