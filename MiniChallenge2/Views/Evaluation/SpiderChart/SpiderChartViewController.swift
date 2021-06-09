//
//  SpiderChartViewController.swift
//  EvaluationPage
//
//  Created by Jackie Leonardy on 06/06/21.
//

import UIKit
import Charts

class SpiderChartViewController: UIViewController {

    lazy var spiderView :RadarChartView = {
        let chartView = RadarChartView(frame: CGRect(x: 0, y: 0, width: 327, height: 186))
        
        chartView.backgroundColor = .clear
        chartView.yAxis.labelFont = .boldSystemFont(ofSize: 0)
        
        let xaxis:XAxis = XAxis()
        let formato:SpiderChartFormatter = SpiderChartFormatter()
        
        var dataSet : [String]! = ["CAR", "LOW", "COR", "UPP"]
        
        formato.setDataSet(data: dataSet)
        for i in 0..<4{
            formato.stringForValue(Double(i), axis: xaxis)
        }
        
        xaxis.valueFormatter = formato
        chartView.xAxis.valueFormatter = xaxis.valueFormatter
        
        chartView.rotationEnabled = false
        chartView.legend.enabled = false
        
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        
        return chartView
    }()
    
    let dataEntry : [RadarChartDataEntry] = [
        RadarChartDataEntry(value: 85.0),
        RadarChartDataEntry(value: 95.0),
        RadarChartDataEntry(value: 85.0),
        RadarChartDataEntry(value: 89.0)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spiderView)
        view.backgroundColor = .clear
        spiderView.delegate = self
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.spiderView.animate(yAxisDuration: 2)
    }

    func setData(){
        let setData1 = RadarChartDataSet(entries: dataEntry)
        setData1.lineWidth = 0
        
        setData1.fill = Fill(color: .cedarChest)
        setData1.fillAlpha = 0.8
        
        setData1.drawValuesEnabled = false
        
        setData1.drawFilledEnabled = true
        
        let data = RadarChartData(dataSet: setData1)
        spiderView.data = data
    }
}

extension SpiderChartViewController: ChartViewDelegate{
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}
