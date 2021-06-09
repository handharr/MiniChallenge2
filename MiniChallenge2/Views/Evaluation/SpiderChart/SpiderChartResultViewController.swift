//
//  SpiderChartResultViewController.swift
//  EvaluationPage
//
//  Created by Jackie Leonardy on 06/06/21.
//

import UIKit

class SpiderChartResultViewController: UIViewController {

    @IBOutlet weak var cardioResult: UILabel!
    @IBOutlet weak var coreResult: UILabel!
    @IBOutlet weak var upperBodyResult: UILabel!
    @IBOutlet weak var lowerBodyResult: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .none
        print("result => \(self.view.frame.height)")
        cardioResult.text = "Need Work"
        coreResult.text = "Excellent"
        upperBodyResult.text = "Excellent"
        lowerBodyResult.text = "Need Work"
    }

}
