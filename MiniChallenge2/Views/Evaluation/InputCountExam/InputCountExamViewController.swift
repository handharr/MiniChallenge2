//
//  InputCountExamViewController.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 14/06/21.
//

import UIKit

class InputCountExamViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inputTextField.keyboardType = .asciiCapableNumberPad
        
        setNavbarButtonItem()
        setBorder()
    }
    
    private func setNavbarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(handleDoneTapped))
        navigationItem.rightBarButtonItem?.tintColor = MCColor.MCColorPrimary
    }
    
    @objc private func handleDoneTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0 - (inputTextField.frame.width / 4),
                                  y: inputTextField.frame.height - (inputTextField.frame.height / 4),
                                  width: inputTextField.frame.width,
                                  height: 3.0)
        bottomLine.backgroundColor = MCColor.MCColorPrimary.cgColor
        inputTextField.layer.addSublayer(bottomLine)
    }
}
