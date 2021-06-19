//
//  StrengthTestLayerResult.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 17/06/21.
//

import UIKit

protocol StrengthTestLayerResultDelegate: NSObject {
    func handleIncorrectTapped()
    func handleDoneTapped()
    func handleCancelTapped()
}

class StrengthTestLayerResult: UIView {
    
    let containerView: UIView = {
        let someView = UIView()
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    
    let primaryLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 100, weight: .bold)
        label.textColor = .white
        label.text = "5"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let secondaryLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 34, weight: .regular)
        label.textColor = .white
        label.text = "rep"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let tersierLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.textColor = .white
        label.text = "Push Up"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = MCColor.MCColorPrimary
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(handleDoneButton), for: .touchUpInside)
        
        return button
    }()
    
    let incorrectButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Incorrect", for: UIControl.State.normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleIncorrectButton), for: .touchUpInside)
        
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .close)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        
        return button
    }()
    
    weak var delegate: StrengthTestLayerResultDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        addSubview(containerView)
        
        containerView.addSubview(primaryLabel)
        containerView.addSubview(secondaryLabel)
        containerView.addSubview(tersierLabel)
        
        addSubview(incorrectButton)
        addSubview(doneButton)
        
        setUpLayout()
    }
    
    private func setUpLayout() {
        var constraints = [NSLayoutConstraint]()
        
        // containerView Constraints
        constraints.append(containerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50))
        constraints.append(containerView.centerXAnchor.constraint(equalTo: centerXAnchor))

        // primaryLabel Constrains
        constraints.append(primaryLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor))
        constraints.append(primaryLabel.topAnchor.constraint(equalTo: containerView.topAnchor))
        constraints.append(primaryLabel.bottomAnchor.constraint(equalTo: tersierLabel.topAnchor))

        // secondaryLabel Constraints
        constraints.append(secondaryLabel.leadingAnchor.constraint(equalTo: primaryLabel.trailingAnchor, constant: 10))
        constraints.append(secondaryLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor))
        constraints.append(secondaryLabel.bottomAnchor.constraint(equalTo: primaryLabel.lastBaselineAnchor))

        // tersierLabel Constraints
        constraints.append(tersierLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor))
        constraints.append(tersierLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor))
        constraints.append(tersierLabel.topAnchor.constraint(equalTo: primaryLabel.bottomAnchor))
        constraints.append(tersierLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor))
        
        // incorrectButton Constraints
        constraints.append(incorrectButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16))
        constraints.append(incorrectButton.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(incorrectButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10))
        
        // doneButton Constraints
        constraints.append(doneButton.leadingAnchor.constraint(equalTo: incorrectButton.trailingAnchor, constant: 10))
        constraints.append(doneButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 16))
        constraints.append(doneButton.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(doneButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10))
        constraints.append(doneButton.widthAnchor.constraint(equalTo: incorrectButton.widthAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func handleIncorrectButton() {
        self.removeFromSuperview()
        delegate?.handleIncorrectTapped()
    }
    
    @objc func handleDoneButton() {
        self.removeFromSuperview()
        delegate?.handleDoneTapped()
    }
    
    @objc func handleCancelButton() {
        self.removeFromSuperview()
        delegate?.handleCancelTapped()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
