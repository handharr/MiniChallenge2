//
//  UIAlertController+.swift
//  MiniChallenge2
//
//  Created by Jackie Leonardy on 13/06/21.
//
import UIKit

extension UIAlertController {
    
    class func show(_ title: String, _ message: String, _ text: String, _ controller: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: text, style: .default))
//        controller.show(alert, sender: nil)
        controller.present(alert, animated: true, completion: nil)
    }
    
}
