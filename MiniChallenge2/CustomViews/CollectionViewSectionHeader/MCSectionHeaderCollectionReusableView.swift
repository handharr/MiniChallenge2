//
//  SectionHeaderCollectionReusableView.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 08/06/21.
//

import UIKit

class MCSectionHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "MCSectionHeaderCollectionReusableView"
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
    }
    
    override func layoutSubviews() {
        textLabel.frame = .init(x: 0, y: 20, width: frame.size.width, height: frame.size.height-20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
