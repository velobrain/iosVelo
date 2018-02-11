//
//  WorkoutCharts.swift
//  490test
//
//  Created by Nicolas Spragg on 2018-02-11.
//  Copyright © 2018 TBD. All rights reserved.
//

import Foundation
import UIKit
import Charts

class WorkoutGoalsChart : UIViewController {
    
   
    
    
    
    @IBOutlet weak var chartView: LineChartView!
    
    func showDistanceChart() {
        
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<totalDistArray.count  {
            let value = ChartDataEntry(x: Double(i * 5), y: totalDistArray[i])
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Distance")
        
        line1.colors = [NSUIColor.blue]
        
        let data = LineChartData()
        
        data.addDataSet(line1)
        
        chartView.data = data
        
        chartView.chartDescription?.text = "Skadoo skadae do you know the way"
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDistanceChart()
    }
}
