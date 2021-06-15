//
//  EvaluationViewController.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 03/06/21.
//

import UIKit

class EvaluationViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var historyTableHeight: NSLayoutConstraint!
    
    let data = History.getData()
    let historyCell = HistoryTableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Evaluation"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setUpTable()
    }
    
    func setUpTable(){
        historyTableView.register(historyCell.getNib(), forCellReuseIdentifier: "historyCell")
        historyTableView.separatorStyle = .none
        
        historyTableView.dataSource = self
        historyTableView.delegate = self
        
        historyTableView.estimatedRowHeight = 100
        historyTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.historyTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        historyTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        self.historyTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
                if let newValue = change?[.newKey] {
                    let newSize = newValue as! CGSize
                    self.historyTableHeight.constant = newSize.height
                }
        }
    }
    
    @IBAction func showMoreTapped(_ sender: UIButton) {
        let historyTableVC = HistoryTableViewController()
        navigationController?.pushViewController(historyTableVC, animated: true)

    }
    
    @IBAction func takeExamTapped(_ sender: Any) {
        let examVC = TakeTestViewController()
        navigationController?.pushViewController(examVC, animated: true)
        Databases.shared.addHistory()
    }
}

extension EvaluationViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        cell.setData(history: data[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}

extension EvaluationViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TestResultViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
