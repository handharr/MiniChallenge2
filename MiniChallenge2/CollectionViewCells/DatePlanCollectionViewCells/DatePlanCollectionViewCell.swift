//
//  DatePlanCollectionViewCell.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 08/06/21.
//

import UIKit

class DatePlanCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DatePlanCollectionViewCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateMonthLabel: UILabel!
    
    static  func nib() -> UINib {
        return UINib(nibName: "DatePlanCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        containerView.layer.cornerRadius = 8
    
        numberLabel.textColor = .white
        topLabel.textColor = .white
        dayLabel.textColor = .white
        dateMonthLabel.textColor = .white
    }
    
    override func prepareForReuse() {
        containerView.backgroundColor = .systemGray4
    }
}
