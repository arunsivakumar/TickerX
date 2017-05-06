////
////  ChartUtils.swift
////  TickerX
////
////  Created by blackbriar on 4/26/17.
////  Copyright © 2017 com.teressa. All rights reserved.
////
//
//import Foundation
//import UIKit
//import Charts
//
//class ChartUtils {
//    
//    static let sharedInsance = ChartUtils()
//    
//    // MARK: Charts
//    func setChart(company: FinRatio, label: String, lineChart: LineChartView) {
//        
//        //remove horizontal grid lines
//        lineChart.xAxis.drawGridLinesEnabled = false
//        
//        //removed left label
//        lineChart.leftAxis.drawLabelsEnabled = false
//        
//        //removed right label
//        lineChart.rightAxis.drawLabelsEnabled = false
//        
//        //removed top label
//        lineChart.xAxis.drawLabelsEnabled = false
//        
//        //removed vertical grid lines
//        lineChart.leftAxis.drawGridLinesEnabled = false
//        lineChart.rightAxis.drawGridLinesEnabled = false
//        
//        lineChart.leftAxis.drawAxisLineEnabled = false
//        lineChart.rightAxis.drawAxisLineEnabled = false
//        lineChart.xAxis.drawAxisLineEnabled = false
//        
//        
//        
//        //DARK BLUE
//        lineChart.backgroundColor = UIColor(hex: 0xEB78FF)
//        lineChart.chartDescription?.text = ""
//        
//        
//        var dataEntries: [ChartDataEntry] = []
//        var count = 0
//        
//        if company.historical.count == 0 {
//            
//            lineChart.data = nil
//            lineChart.noDataText = "The Data for this Financial Ratio is not available."
//            lineChart.noDataTextColor = NSUIColor.white
//            
//        } else {
//            for (_, value) in (company.historical){
//                
//                let dataEntry = ChartDataEntry(x: Double(count), y: value)
//                dataEntries.append(dataEntry)
//                count += 1
//            }
//            let lineChartDataSet = LineChartDataSet(values: dataEntries, label: label)
//            let lineChartData = LineChartData(dataSet: lineChartDataSet)
//            lineChart.data = lineChartData
//            lineChartDataSet.valueTextColor = NSUIColor.white
//            
//        }
//        
//    }
//    
//    
//    
//}
