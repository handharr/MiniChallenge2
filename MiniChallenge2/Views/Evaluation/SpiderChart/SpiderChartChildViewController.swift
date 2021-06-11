//
//  SpiderChartChildViewController.swift
//  EvaluationPage
//
//  Created by Jackie Leonardy on 06/06/21.
//

import UIKit
import Charts

class SpiderChartChildViewController: UIViewController {
    
    
    let spiderChartChildView = SpiderChartViewController()
    
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var spiderChartView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cultured
        self.view.layer.cornerRadius = 20
    }
    
    func setConstraint(){
//        spiderChartChildView.view.translatesAutoresizingMaskIntoConstraints = false
//        spiderChartChildView.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
//        spiderChartChildView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//        spiderChartChildView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -416).isActive = true
      
//        spiderChartChildView.view.bottomAnchor.constraint(equalTo: resultView.topAnchor, constant: -24).isActive = true
//        spiderChartChildView.view.heightAnchor.constraint(equalToConstant: 318).isActive = true
////        spiderChartChildView.view.widthAnchor.constraint(equalToConstant: 186).isActive = true
        
    }
    
    func addSpiderView(){
        addChild(spiderChartChildView)
        view.addSubview(spiderChartChildView.view)
        spiderChartChildView.didMove(toParent: self)
        setConstraint()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            super.prepare(for: segue, sender: sender)

            if let childViewController = segue.destination as? SpiderChartViewController {
                childViewController.view.translatesAutoresizingMaskIntoConstraints = false
//                childViewController.view.frame.size.height = spiderChartView.frame.height
//                childViewController.view.frame.size.width = spiderChartView.frame.width
//                childViewController.spiderView.frame.size.width = spiderChartView.frame.width-(spiderChartView.frame.width/20)
//                childViewController.spiderView.frame.size.height = spiderChartView.frame.height
//                print("aaa \(spiderChartView.frame.width)")
            }
    }
}
