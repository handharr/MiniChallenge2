//
//  StrengthTestLayerStart.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 17/06/21.
//

import UIKit

class StrengthTestLayerStart: UIView {
    
    let label: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 100, weight: .bold)
        label.textColor = .white
        label.text = "Push Up for 2 Minutes"
        label.numberOfLines = 0
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
