//
//  MyPlanViewController.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 03/06/21.
//

import UIKit

class MyPlanViewController: UIViewController {

    @IBOutlet weak var planTableView: UITableView!
    
    let firstHeaderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let secondHeaderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Plan"
        
        planTableView.backgroundColor = .systemBackground

        setTableView()
    }
    
    private func setTableView() {
        planTableView.delegate = self
        planTableView.dataSource = self
        planTableView.register(PlanTableViewCell.nib(), forCellReuseIdentifier: PlanTableViewCell.identifier)
    }
}

extension MyPlanViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : DummyData.shared.getOtherPlan().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlanTableViewCell.identifier, for: indexPath) as! PlanTableViewCell
        
        if indexPath.section == 0 {
            guard let model = DummyData.shared.getOnGoing() else {
                return cell
            }
            cell.configureUI(model: model)
        } else {
            let models = DummyData.shared.getOtherPlan()
            cell.configureUI(model: models[indexPath.row])
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: .init(x: 0, y: 0, width: view.frame.size.width, height: 30))

        if section == 0 {
            firstHeaderLabel.frame = header.bounds
            firstHeaderLabel.text = "On Going"
            header.addSubview(firstHeaderLabel)
            return header
        } else {
            secondHeaderLabel.frame = header.bounds
            secondHeaderLabel.text = "Other Plan"
            header.addSubview(secondHeaderLabel)
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
}
