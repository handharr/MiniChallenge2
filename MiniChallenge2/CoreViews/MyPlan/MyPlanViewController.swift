//
//  MyPlanViewController.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 03/06/21.
//

import UIKit

class MyPlanViewController: UIViewController {

    @IBOutlet weak var planTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Plan"
        view.backgroundColor = .systemPink
        
        planTableView.backgroundColor = .systemPink
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
        return section == 0 ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlanTableViewCell.identifier, for: indexPath) as! PlanTableViewCell
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
