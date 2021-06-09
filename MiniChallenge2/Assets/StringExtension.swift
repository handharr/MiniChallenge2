//
//  StringExtension.swift
//  EvaluationPage
//
//  Created by Jackie Leonardy on 08/06/21.
//

import UIKit

extension NSMutableAttributedString {
    var fontSize:CGFloat { return 18 }
//    var boldFont:UIFont { return UIFont(name: "Tsukushi A Round Gothic Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize) }
//    var normalFont:UIFont { return UIFont(name: "Tsukushi A Round Gothic Bold Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}

    var boldFont:UIFont { return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight(0.6)) }
    var normalFont:UIFont { return UIFont.systemFont(ofSize: fontSize)}
    
    
    func bold(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func underlined(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
