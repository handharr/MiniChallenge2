//
//  SectionButtonCollectionView.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 13/06/21.
//

import UIKit

class SectionButtonCollectionView: UICollectionReusableView {
    
    static let identifier = "SectionButtonCollectionView"
    static func nib() -> UINib {
        return UINib(nibName: "SectionButtonCollectionView", bundle: nil)
    }

    @IBOutlet weak var startButton: UIButton!
    
    var navigate: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        startButton.layer.cornerRadius = 8
    }
    
    @IBAction func handleStartButton(_ sender: Any) {
        navigate?()
    
    }
}
