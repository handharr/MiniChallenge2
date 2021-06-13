//
//  TakeTestViewController.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 03/06/21.
//

import UIKit

class TakeTestViewController: UIViewController {

    @IBOutlet weak var takeTestTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Take Test"
        setTableView()
        
    }
    
    private func setTableView() {
        takeTestTableView.delegate = self
        takeTestTableView.dataSource = self
        takeTestTableView.backgroundColor = .systemBackground
        
        takeTestTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        takeTestTableView.register(TakeTestTableViewCells.nib(), forCellReuseIdentifier: TakeTestTableViewCells.identifier)
    }
    
}

extension TakeTestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DummyData.shared.dummyTest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        defaultCell.backgroundColor = MCColor.MCColorPrimary
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TakeTestTableViewCells.identifier, for: indexPath) as? TakeTestTableViewCells else {
            return defaultCell
        }
        
        let data = DummyData.shared.dummyTest[indexPath.row]
        cell.configureUI(with: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
