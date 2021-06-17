//
//  StrengthResultTableViewCells.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 18/06/21.
//

import UIKit

class StrengthResultTableViewCells: UITableViewCell {
    
    static let identifier = "StrengthResultTableViewCells"
    static func nib() -> UINib {
        return UINib(nibName: "StrengthResultTableViewCells", bundle: nil)
    }

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configureUI(count: Int) {
        countLabel.text = "\(count)"
    }
}
