//
//  ExcerciseDetailPlanCollectionViewCell.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 08/06/21.
//

import UIKit

class ExcerciseDetailPlanCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ExcerciseDetailPlanCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ExcerciseDetailPlanCollectionViewCell", bundle: nil)
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    private func setupUI() {
        imageView.backgroundColor = .systemGray4
        subtitleLabel.textColor = MCColor.MCColorPrimary
        containerView.layer.cornerRadius = 8
    }
}
