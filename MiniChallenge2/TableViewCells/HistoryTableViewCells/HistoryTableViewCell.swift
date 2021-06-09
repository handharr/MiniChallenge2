//
//  HistoryTableViewCell.swift
//  EvaluationPage
//
//  Created by Jackie Leonardy on 07/06/21.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var evaluationImage: UIImageView!
    @IBOutlet weak var evaluationType: UILabel!
    @IBOutlet weak var evaluationResult: UILabel!
    @IBOutlet weak var evaluationHistoryDate: UILabel!
    
    func getNib() -> UINib{
        return UINib(nibName: "\(HistoryTableViewCell.self)", bundle: nil)
    }
    
    func setData(history data : History){
        evaluationType.text = data.evaluationType?.rawValue
        evaluationResult.text = data.evaluationType?.calculateResult()
        evaluationHistoryDate.text = "\(data.date)"
        evaluationImage.image = data.evaluationType?.getPict()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 10
        evaluationImage.layer.cornerRadius = 10
        evaluationImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.selectionStyle =  UITableViewCell.SelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 1, left: 16, bottom: 1, right: 16))
    }
    
}
