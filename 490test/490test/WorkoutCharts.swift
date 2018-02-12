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
   
    @IBOutlet weak var pulseChartView: LineChartView!
    
    func showSpeedChart() {
        
        var lineChartEntryDistance = [ChartDataEntry]()
        for i in 0..<totalDistArray.count  {
            let currentSpeedValue = ChartDataEntry(x: Double(i * 5), y: totalDistArray[i]/Double((i+1)*5))
            lineChartEntryDistance.append(currentSpeedValue)
        }
        let currentSpeedLine = LineChartDataSet(values: lineChartEntryDistance, label: "Speed")
        currentSpeedLine.colors = [NSUIColor.blue]
        currentSpeedLine.circleRadius = 1
    
        let data = LineChartData()
    
        data.addDataSet(currentSpeedLine)
        chartView.data = data
        chartView.animate(xAxisDuration: 2, yAxisDuration: 2)
        chartView.chartDescription?.text = "Distance Chart"
    }
    
    
    func showPulseChart() {
        
        var lineChartEntryPulse = [ChartDataEntry]()
        for i in 0..<pulseArray.count  {
            let pulseValue = ChartDataEntry(x: Double(i * 5), y: 60*pulseArray[i] / Double((i + 1) * 5))
            lineChartEntryPulse.append(pulseValue)
        }
        let pulseLine = LineChartDataSet(values: lineChartEntryPulse, label: "Pulse")
        pulseLine.colors = [NSUIColor.red]
        pulseLine.circleRadius = 1
        let data = LineChartData()
        data.addDataSet(pulseLine)
        pulseChartView.data = data
        pulseChartView.animate(xAxisDuration: 2, yAxisDuration: 2)
        pulseChartView.chartDescription?.text = "Pulse Chart"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpeedChart()
        showPulseChart()
    }
}
