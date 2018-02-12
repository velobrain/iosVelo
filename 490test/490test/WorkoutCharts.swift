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
    
    func showDistanceChart() {
        
        var lineChartEntryDistance = [ChartDataEntry]()
        for i in 0..<totalDistArray.count  {
            let distanceValue = ChartDataEntry(x: Double(i * 5), y: totalDistArray[i])
            lineChartEntryDistance.append(distanceValue)
        }
        let distanceLine = LineChartDataSet(values: lineChartEntryDistance, label: "Distance")
        distanceLine.colors = [NSUIColor.blue]
        distanceLine.circleRadius = 1
    
        let data = LineChartData()
    
        data.addDataSet(distanceLine)
        chartView.data = data
        chartView.chartDescription?.text = "Distance Chart"
        
    }
    
    
    func showPulseChart() {
        
        var lineChartEntryDistance = [ChartDataEntry]()
        for i in 0..<pulseArray.count  {
            let pulseValue = ChartDataEntry(x: Double(i * 5), y: pulseArray[i] / Double((i * 5)))
            lineChartEntryDistance.append(pulseValue)
        }
        let pulseLine = LineChartDataSet(values: lineChartEntryDistance, label: "Pulse")
        pulseLine.colors = [NSUIColor.red]
        let data = LineChartData()
        data.addDataSet(pulseLine)
        pulseChartView.data = data
        pulseChartView.chartDescription?.text = "Pulse Chart"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDistanceChart()
        //showPulseChart()
    }
}
