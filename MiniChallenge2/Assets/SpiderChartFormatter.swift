//
//  SpiderChartFormatter.swift
//  EvaluationPage
//
//  Created by Jackie Leonardy on 06/06/21.
//

import UIKit
import Foundation
import Charts

@objc(SpiderChartFormatter)
public class SpiderChartFormatter: NSObject, IAxisValueFormatter{

    var months: [String]! = ["Data1", "Data2", "Data3", "Data4"]


    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {

        return months[Int(value)]
    }
    
    public func setDataSet(data : [String]){
        months = data
    }
}
