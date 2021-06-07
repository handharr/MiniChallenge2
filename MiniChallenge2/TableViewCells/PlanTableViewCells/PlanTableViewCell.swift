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
    @IBOutlet weak var containerView: UIView!
    
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
    
    func configureUI(model: Plan) {
        titleLabel.text = model.name
        titleLabel.textColor = .white
        subtitleLabel.text = model.description
        subtitleLabel.textColor = .white
        infoLabel.text = "\(model.workoutPerDay) workout/days"
        infoLabel.textColor = .white
        countLabel.text = "\(model.daysPerWeek) days/week"
        containerView.backgroundColor = UIColor(patternImage: model.planImage)
        containerView.layer.cornerRadius = 8
    }
}
