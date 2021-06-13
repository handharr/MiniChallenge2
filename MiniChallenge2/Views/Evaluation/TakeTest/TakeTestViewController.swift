//
//  TakeTestViewController.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 03/06/21.
//

import UIKit
import WatchConnectivity

class TakeTestViewController: UIViewController {
    
    @IBOutlet weak var takeTestTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard let supported = WCSession.isSupported() else { }
        
        let session = WCSession.default
        session.delegate = self
        session.activate() // activate the session

        if session.isPaired {
            
        }
        
        // Ini kerjaannya Celle
        //
        // --------
        title = "Take Test"
        setTableView()
    }
    
    private func setTableView() {
        takeTestTableView.delegate = self
        takeTestTableView.dataSource = self
        takeTestTableView.backgroundColor = .systemBackground
        
        takeTestTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        takeTestTableView.register(TakeTestTableViewCell.nib(), forCellReuseIdentifier: TakeTestTableViewCell.identifier)
    }
    
}

// MARK: - Table View Delegation
extension TakeTestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DummyData.shared.dummyTest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        defaultCell.backgroundColor = MCColor.MCColorPrimary
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TakeTestTableViewCell.identifier, for: indexPath) as? TakeTestTableViewCell else {
            return defaultCell
        }
        
        let data = DummyData.shared.dummyTest[indexPath.row]
        cell.configureUI(with: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = MCTableViewSectionHeader(frame: .init(x: 0,
                                                           y: 0,
                                                           width: tableView.frame.width,
                                                           height: 50))
        header.textLabel.text = "Test Your Skills!"
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}

// MARK: - Watch Kit Delegation
extension TakeTestViewController: WCSessionDelegate{
    func sessionDidDeactivate(_ session: WCSession) {
    
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //yang pertama direach
    }
}
