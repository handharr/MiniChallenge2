//
//  TakeTestViewController.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 03/06/21.
//

import UIKit
import WatchConnectivity

protocol CardioTestDelegate{
    func phoneDidChosen(didPhoneChosen : Bool)
}

class TakeTestViewController: UIViewController {
    
    @IBOutlet weak var takeTestTableView: UITableView!
    var session: WCSession?
    var delegate: CardioTestDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func choosingAlert() {
        let alert = UIAlertController(title: "Cardio Test", message: "Choose your Cardio Test device companion!", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Apple Watch", style: .default, handler: { (_) in
            self.checkingWatchPaired()
        }))

        alert.addAction(UIAlertAction(title: "Phone", style: .default, handler: { (_) in
            self.navigateToCardioTest(isUsingPhone: true)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (_) in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkingWatchPaired(){
        if ((session?.isPaired) != nil) {
            let alert = UIAlertController(title: "Continue?", message: "Your Apple Watch is Paired with your iPhone", preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: { _ in }))
            
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {_ in
                    let data = ["data" : "\(UUID())"]
                    if HealthModel.hasRequestedHealthData{
                        do{
                            try self.session?.updateApplicationContext(data)
                        }catch{
                            
                        }
                        self.navigateToCardioTest(isUsingPhone: false)
                    } else {
                        HealthModel.setUpHealthRequest(){
                            do{
                                try self.session?.updateApplicationContext(data)
                            }catch{
                                
                            }    
                            DispatchQueue.main.async {
                                self.navigateToCardioTest(isUsingPhone: false)
                            }
                        }
                    }
//                    self.session?.transferUserInfo(data)
//                    if ((self.session?.isReachable) != nil){
//                        self.session?.sendMessage(data, replyHandler: nil, errorHandler: { (error) in
//                            print(error)
//                        })
//                    }
                }))
            self.present(alert, animated: true, completion: nil)

        } else {
            UIAlertController.show("Apple Watch", "You don't have any Apple Watch paired", "Oke", self)
        }
    }
    
    func phoneDidChosen(didPhoneChosen: Bool) {
        
    }
    
    func navigateToCardioTest(isUsingPhone: Bool){
        let cardioTest = CardioTestViewController()
        cardioTest.setObserver()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Chosing Phone Notification"), object: nil, userInfo: ["isUsingPhone": isUsingPhone])
        self.navigationController?.pushViewController(cardioTest, animated: true)
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
        if indexPath.row == 0{
            if WCSession.isSupported(){
                session = WCSession.default
                
                session?.delegate = self
                session?.activate()
                choosingAlert()
            }
        }
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
        print("iPhone Session Success")
    }
}
