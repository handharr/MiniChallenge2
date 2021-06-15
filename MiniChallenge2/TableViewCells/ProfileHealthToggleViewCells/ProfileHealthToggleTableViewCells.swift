//
//  ProfileHealthToggleTableViewCells.swift
//  MiniChallenge2
//
//  Created by Jackie Leonardy on 14/06/21.
//

import UIKit

protocol profileSyncDelegate{
    func syncDidTapped(isTapped: Bool)
}

class ProfileHealthToggleTableViewCells: UITableViewCell {
    var isSwitched : Bool = true
    var delegate : profileSyncDelegate?
    
    static func getNib() -> UINib{
        return UINib(nibName: "\(ProfileHealthToggleTableViewCells.self)", bundle: nil)
    }
    
    static func getIdentifier() -> String{
        return "ProfileHealthToggleTableViewCells"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func healthSyncTapped(_ sender: Any) {
        delegate?.syncDidTapped(isTapped: isSwitched)
    }
}
