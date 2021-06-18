//
//  StrengthTestResultViewController.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 18/06/21.
//

import UIKit

class StrengthTestResultViewController: UIViewController {
    
    @IBOutlet weak var resultTableView: UITableView!
    public var pushUPCount = 0
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Finish", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MCColor.MCColorPrimary
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Strength Test Result"
        resultTableView.backgroundColor = .systemBackground
        
        setUpTableView()
    }
    
    private func setUpTableView() {
        resultTableView.delegate = self
        resultTableView.dataSource = self
        
        resultTableView.register(GradingCriteriaTableViewCell.getNib(), forCellReuseIdentifier: GradingCriteriaTableViewCell.getIdentifier())
        resultTableView.register(StrengthResultTableViewCells.nib(), forCellReuseIdentifier: StrengthResultTableViewCells.identifier)
    }
    
    @objc private func handleFinishButton() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension StrengthTestResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let resultCell = tableView.dequeueReusableCell(withIdentifier: StrengthResultTableViewCells.identifier, for: indexPath) as! StrengthResultTableViewCells
            resultCell.configureUI(count: pushUPCount)
            return resultCell
        } else {
            let gradingCell = tableView.dequeueReusableCell(withIdentifier: GradingCriteriaTableViewCell.getIdentifier(), for: indexPath) as! GradingCriteriaTableViewCell
            gradingCell.setData()
            gradingCell.workOutCriteria.text = "Push Up (2 Min)"
            return gradingCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 1 ? 215 : 214
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let header = MCTableViewSectionHeader(frame: .init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            header.textLabel.text = "Grading Criteria"
            return header
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        section == 1 ? 50 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        button.addTarget(self, action: #selector(handleFinishButton), for: .touchUpInside)
        
        button.frame = .init(x: 0, y: 0, width: tableView.frame.width, height: 50)
        
        return section == 1 ? button : nil
    }
}
