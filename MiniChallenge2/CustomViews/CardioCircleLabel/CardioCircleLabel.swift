//
//  CardioCircleLabel.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 13/06/21.
//

import UIKit

class CardioCircleLabel: UIView {
    
    let topLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 100, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "0,78"
        
        return label
    }()
    
    let bottomLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Kilometer"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(topLabel)
        addSubview(bottomLabel)
    }
    
    override func layoutSubviews() {
        topLabel.frame = .init(x: 0, y: 0, width: frame.width, height: 115)
        bottomLabel.frame = .init(x: 0, y: topLabel.frame.height, width: frame.width, height: 28)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
