//
//  ProfileHealthToggleTableViewCells.swift
//  MiniChallenge2
//
//  Created by Jackie Leonardy on 14/06/21.
//

import UIKit

protocol profileSyncDelegate{
    func syncDidTapped(isSwitched: Bool)
}

class ProfileHealthToggleTableViewCells: UITableViewCell {
    var isSwitched : Bool = UserDefaults.standard.bool(forKey: "healthSyncswitch")
    var delegate : profileSyncDelegate?
    
    @IBOutlet weak var syncSwitch: UISwitch!
    
    static func getNib() -> UINib{
        return UINib(nibName: "\(ProfileHealthToggleTableViewCells.self)", bundle: nil)
    }
    
    static func getIdentifier() -> String{
        return "ProfileHealthToggleTableViewCells"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        syncSwitch.isOn = UserDefaults.standard.bool(forKey: "healthSyncswitch")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func healthSyncTapped(_ sender: Any) {
        UserDefaults.standard.setValue(!UserDefaults.standard.bool(forKey: "healthSyncswitch"), forKey: "healthSyncswitch")
        
        if UserDefaults.standard.bool(forKey: "healthSyncswitch") {
            HealthModel.setUpHealthRequest {
                self.delegate?.syncDidTapped(isSwitched: UserDefaults.standard.bool(forKey: "healthSyncswitch"))
            }
        }
        else {
            self.delegate?.syncDidTapped(isSwitched: UserDefaults.standard.bool(forKey: "healthSyncswitch"))
        }

    }
}
