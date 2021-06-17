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
    
    public func configureUI(idx: Int) {
        
        let date = Date()
        let formatter = DateFormatter()
        
        if idx == 0 {
            containerView.backgroundColor = MCColor.MCColorPrimary
        }
        
        numberLabel.text = "\(idx + 1)"
        
        if idx == 0 {
            formatter.dateFormat = "E"
            dayLabel.text = formatter.string(from: date)
            formatter.dateFormat = "d MMM"
            dateMonthLabel.text = formatter.string(from: date)
        } else {
            formatter.dateFormat = "E"
            let dateNow = Calendar.current.date(byAdding: .day, value: idx*3, to: date)!
            dayLabel.text = "\(formatter.string(from: dateNow))"
            formatter.dateFormat = "d MMM"
            dateMonthLabel.text = formatter.string(from: dateNow)
        }
    }
    
    override func prepareForReuse() {
        containerView.backgroundColor = .systemGray4
    }
}
