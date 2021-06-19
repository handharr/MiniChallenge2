//
//  SelectDayViewController.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 19/06/21.
//

import UIKit

class SelectDayViewController: UIViewController {

    @IBOutlet weak var stackLabel: UIStackView!
    
    var selectedAmount: Int = 3
    var selectedDays: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Select Day"
        
        for (idx, item) in stackLabel.subviews.enumerated() {
            item.layer.cornerRadius = 8
            item.tag = idx
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        
        setupUI()
    }
    
    private func setupUI() {
        for (idx, item) in stackLabel.subviews.enumerated() {
            let item = item as! UIButton
            
            if selectedDays.contains(idx) {
                item.backgroundColor = MCColor.MCColorPrimary
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
        selectedDays.removeAll()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func handleButtonTapped(_ sender: UIButton) {
        
        let idx = sender.tag
        
        if selectedDays.contains(idx) {
            selectedDays.remove(at: selectedDays.firstIndex(of: idx)!)
            sender.backgroundColor = .systemGray5
            return
        }
        
        if selectedDays.count == selectedAmount {
            return
        }
        
        selectedDays.append(idx)
        sender.backgroundColor = MCColor.MCColorPrimary
    }
    
    @objc private func handleDone() {
        if selectedDays.count == selectedAmount {
            let ac = UIAlertController(title: "Start a new plan",
                                       message: "Are you sure you want to start this plan?\nAny ongoing plan would be replaced.",
                                       preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: nil, message: "Please Select \(selectedAmount) Days", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(ac, animated: true)
        }
    }
}
