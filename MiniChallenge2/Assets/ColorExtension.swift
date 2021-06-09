//
//  ColorExtension.swift
//  EvaluationPage
//
//  Created by Jackie Leonardy on 08/06/21.
//

import UIKit

extension UIColor{
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static let sweetBrown = UIColor.rgb(r: 157, g: 54, b: 46)
    static let mediumCarmine = UIColor.rgb(r: 178, g: 63, b: 57)
    static let cedarChest = UIColor.rgb(r: 198, g: 81, b: 72)
    static let cultured = UIColor.rgb(r: 240, g: 240, b: 240)
}
