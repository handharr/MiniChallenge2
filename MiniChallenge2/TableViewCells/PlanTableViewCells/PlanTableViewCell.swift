//
//  PlanTableViewCell.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 04/06/21.
//

import UIKit

class PlanTableViewCell: UITableViewCell {
    static let identifier = "PlanTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "PlanTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var labelContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelContainer.layer.cornerRadius = 8
        
        setupUI()
    }
    
    func setupUI() {
        titleLabel.text = "Judul Label"
        subtitleLabel.text = "Description Label"
        infoLabel.text = "4 workout/days"
        countLabel.text = "2 days/week"
    }
}
