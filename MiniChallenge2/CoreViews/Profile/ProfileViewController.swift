//
//  ProfileViewController.swift
//  MiniChallenge2
//
//  Created by Jackie Leonardy on 14/06/21.
//

import UIKit
import HealthKit

class ProfileViewController: UIViewController {

    var delegate: ProfileHealthToggleTableViewCells!
    
    var profileSection : [String] = Profile.returnProfileSection()
    var profileData : [String] = Profile.returnProfileData(Profile.profile)()
    let table = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        view.backgroundColor = .systemTeal
        setUpTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileSection = Profile.returnProfileSection()
        profileData = Profile.returnProfileData(Profile.profile)()
        table.reloadData()
    }
    
    func setUpTable(){
        print(view.frame.width)
        print(UIScreen.main.bounds.width)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        table.register(ProfileHealthToggleTableViewCells.getNib(), forCellReuseIdentifier: ProfileHealthToggleTableViewCells.getIdentifier())
        table.delegate = self
        table.dataSource = self
        table.allowsSelection = false
        table.isScrollEnabled = false
        table.backgroundColor = .white
        view.addSubview(table)
    }
    
    override func viewDidLayoutSubviews() {
        table.edgeTo(view: view)
    }
}

extension ProfileViewController: UITableViewDelegate{
    
}

extension ProfileViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 4
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
                
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.font = .systemFont(ofSize: 22, weight: .bold)
        
        if section == 0{
            label.text = "Detail"
        }
        else {
            label.text = "Setting"
        }
                
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "To allow data access from Health go to Settings > Health > Data Access & Devices > Nama App > and click “Turn All Categories On“"
        }
        return "Nama aplikasi reads your Medical ID data from Apple Healh"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
            cell.textLabel?.text = profileSection[indexPath.row]
            
            let rightAccessory = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: cell.frame.height-22))
            let label = UILabel()
            
            label.frame = CGRect.init(x: 0, y: 0, width: 100, height: rightAccessory.frame.height)
            label.font = .systemFont(ofSize: 16)
            label.text = profileData[indexPath.row]
            label.textAlignment = .right
            label.textColor = .systemGray
            rightAccessory.addSubview(label)
                
            cell.accessoryView = rightAccessory
            cell.backgroundColor = .cultured
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileHealthToggleTableViewCells.getIdentifier(), for: indexPath) as! ProfileHealthToggleTableViewCells
        cell.backgroundColor = .cultured
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
    }
    
}

extension ProfileViewController: profileSyncDelegate{
    func syncDidTapped(isSwitched: Bool) {
        if !isSwitched{
            profileSection = Profile.returnProfileSection()
            profileData = Profile.returnProfileData(Profile.profile)()
        }
        else {
            profileData = Profile.returnProfileEmpty(Profile.profile)()
        }
        let sectionToReload = 0
        let indexSet: IndexSet = [sectionToReload]

        self.table.reloadSections(indexSet, with: .none)
    }
}
