//
//  HistoryTableViewController.swift
//  EvaluationPage
//
//  Created by Jackie Leonardy on 08/06/21.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    let historyCell = HistoryTableViewCell()
    let data = History.getData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "History"
        navigationController?.navigationBar.prefersLargeTitles = true
        setUpTable()
    }

    func registerXIBCell(cell : UITableViewCell){
        tableView.register(UINib(nibName: "\(cell.self)", bundle: nil), forCellReuseIdentifier: "historyCell")
    }
    
    func setUpTable(){
        tableView.register(historyCell.getNib(), forCellReuseIdentifier: "historyCell")
        tableView.separatorStyle = .none
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        cell.setData(history: data[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TestResultViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
