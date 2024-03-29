//
//  PlanCollectionViewCells.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 09/06/21.
//

import UIKit

class PlanCollectionViewCells: UICollectionViewCell {
    
    static let identifier = "PlanCollectionViewCells"
    static func nib() -> UINib {
        return UINib(nibName: "PlanCollectionViewCells", bundle: nil)
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var labelContainer: UIView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.textColor = .white
        descriptionLabel.textColor = .white
        labelContainer.layer.cornerRadius = 8
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
    }

    public func configureUI(model: Plan) {
        titleLabel.text = model.name
        descriptionLabel.text = model.description
        subtitleLabel.text = "\(model.workoutPerDay) workout/days"
        containerView.backgroundColor = UIColor(patternImage: model.planImage)
    }
    
    public func configureUI(model: PlanModel) {
        titleLabel.text = model.name
        descriptionLabel.text = model.desc
        subtitleLabel.text = "\(model.workoutPerDay) workout/days"
        
        switch model.name {
        case "All in One Plan":
            backgroundImageView.image = UIImage(named: "plan-image-1")
        case "Strength Plan":
            backgroundImageView.image = UIImage(named: "plan-image-2")
        default:
            backgroundImageView.image = UIImage(named: "plan-image-3")
        }
    }
    
    override func prepareForReuse() {
        setupUI()
    }
}
