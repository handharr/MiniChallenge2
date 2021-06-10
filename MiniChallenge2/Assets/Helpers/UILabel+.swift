//
//  UILabel+.swift
//  MiniChallenge2
//
//  Created by Jackie Leonardy on 10/06/21.
//

import UIKit

public extension UILabel{
    
    func edgeTo(view: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
}
