//
//  TakeTestTableViewCell.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 13/06/21.
//

import UIKit

class TakeTestTableViewCell: UITableViewCell {
    
    static let identifier = "TakeTestTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "TakeTestTableViewCell", bundle: nil)
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var chevronImage: UIImageView!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureUI(with model: Test) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        descriptionLabel.text = model.desc
        imageIcon.image = model.imageIcon
    }
}
