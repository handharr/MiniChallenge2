//
//  TakeTestTableViewCells.swift
//  MiniChallenge2
//
//  Created by Veronica Michelle Darmabudi on 10/06/21.
//

import UIKit

class TakeTestTableViewCells: UITableViewCell {
    
    static let identifier = "TakeTestTableViewCells"
    static func nib() -> UINib {
        return UINib(nibName: "TakeTestTableViewCells", bundle: nil)

    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.layer.cornerRadius = 8
    }
    
    func configureUI(with model: Test) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        descLabel.text = model.desc
        imageIcon.image = model.imageIcon
    }
}
