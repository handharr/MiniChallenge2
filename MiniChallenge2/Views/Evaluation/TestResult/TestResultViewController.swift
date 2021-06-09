//
//  TestResultViewController.swift
//  MiniChallenge2
//
//  Created by Jackie Leonardy on 09/06/21.
//

import UIKit

class TestResultViewController: UIViewController {

    @IBOutlet weak var resultTable: UITableView!
    
    let testResult : [History]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cardio Test Result"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setUpTable()
    }
    
    func setUpTable(){
        resultTable.register(CardioTableViewCell.getNib(), forCellReuseIdentifier: CardioTableViewCell.getIdentifier())
        resultTable.register(GradingCriteriaTableViewCell.getNib(), forCellReuseIdentifier: GradingCriteriaTableViewCell.getIdentifier())
        resultTable.delegate = self
        resultTable.dataSource = self
    }
}

extension TestResultViewController: UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = MCTableViewSectionHeader(frame: .init(x: 0, y: 0, width: view.frame.size.width, height: 30))

        if section == 0 {
            header.textLabel.text = "Result"
            header.textLabel.frame.size.height = 40
            print(header.textLabel.frame.height)
            print(header.frame.height)
            
            return header
        } else {
            header.textLabel.text = "Grading Criteria"
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        214
    }
}

extension TestResultViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let resultCell = tableView.dequeueReusableCell(withIdentifier: CardioTableViewCell.getIdentifier(), for: indexPath) as! CardioTableViewCell
            return resultCell
        }
        
        else {
            let gradingCell = tableView.dequeueReusableCell(withIdentifier: GradingCriteriaTableViewCell.getIdentifier(), for: indexPath) as! GradingCriteriaTableViewCell
            gradingCell.setData()
            return gradingCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
}
