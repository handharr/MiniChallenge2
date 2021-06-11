//
//  UIView.swift
//  MiniChallenge2
//
//  Created by Jackie Leonardy on 10/06/21.
//

import UIKit

public extension UIView {
    func pinTo(view: UIView, tabBar: UITabBar){
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -((tabBar.frame.height) - 12)).isActive = true
    }
}
