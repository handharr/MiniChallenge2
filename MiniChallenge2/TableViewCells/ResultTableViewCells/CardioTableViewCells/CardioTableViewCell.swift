//
//  CardioTableViewCell.swift
//  MiniChallenge2
//
//  Created by Jackie Leonardy on 09/06/21.
//

import UIKit

class CardioTableViewCell: UITableViewCell {

    @IBOutlet weak var testResult: UILabel!
    @IBOutlet weak var runningTime: UILabel!
    @IBOutlet weak var vo2MaxResult: UILabel!
    @IBOutlet weak var testDate: UILabel!
    @IBOutlet weak var cellContainer: UIView!
    
    func setUpData(index: Int){
        let data = History.getData()
        let dataIndex = data[index]
        self.runningTime.text = dataIndex.time
        self.testDate.text = dataIndex.date
        self.vo2MaxResult.text = dataIndex.evaluationType?.calculateVO2Max()
        self.testResult.text = dataIndex.evaluationType?.calculateResult()
    }
    
    static func getNib() -> UINib {
        return UINib(nibName: "\(CardioTableViewCell.self)", bundle: nil)
    }
    
    static func getIdentifier() -> String{
        return "cardioTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellContainer.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
