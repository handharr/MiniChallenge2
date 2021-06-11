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
        chartView.yAxis.labelCount = 10
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        
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
        
        return chartView
    }()
    
    let dataEntry : [RadarChartDataEntry] = [
        RadarChartDataEntry(value: 85.0),
        RadarChartDataEntry(value: 55.0),
        RadarChartDataEntry(value: 20.0),
        RadarChartDataEntry(value: 89.0)
    ]
    
    let dataEntry2 : [RadarChartDataEntry] = [
        RadarChartDataEntry(value: 80.0),
        RadarChartDataEntry(value: 10.0),
        RadarChartDataEntry(value: 70.0),
        RadarChartDataEntry(value: 15.0)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spiderView)
        view.backgroundColor = .clear
        spiderView.delegate = self
        setData()
        self.spiderView.animate(yAxisDuration: 2)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.spiderView.animate(yAxisDuration: 2)
//    }

    func setData(){
        let setData1 = RadarChartDataSet(entries: dataEntry)
        setData1.lineWidth = 0
        
        setData1.fill = Fill(color: .cedarChest)
        setData1.fillAlpha = 0.8
        
        setData1.drawValuesEnabled = false
        
        setData1.drawFilledEnabled = true
        
        let setData2 = RadarChartDataSet(entries: dataEntry2)
        setData2.lineWidth = 0
        
        setData2.fill = Fill(color: .cedarChest)
        setData2.fillAlpha = 0
        
        setData2.drawValuesEnabled = false
        
        setData2.drawFilledEnabled = true
        
        let data = RadarChartData(dataSets: [setData1, setData2])
        data.setDrawValues(false)
        spiderView.data = data
        
    }
}

extension SpiderChartViewController: ChartViewDelegate{
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}
