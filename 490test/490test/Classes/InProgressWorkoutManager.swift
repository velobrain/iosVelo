//
//  InProgressWorkoutManager.swift
//  490test
//
//  Created by Nicolas Spragg on 2017-12-03.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation

//used while the workout is in progress/
//Used by the coach class to get info.
// handles incoming BLE data by averaging it etc
var pitchArray =  [Double]()
var totalDistArray = [Double]()
var pulseArray =  [Double]()
var currentSpeedArray = [Double]()
var onTrackForGoalsCounter : Double =  0
class InProgessWorkoutManager {
    
    
    init() {
        pitchArray = []
        totalDistArray = []
        pulseArray = []
    }
    
    func newEntry(pitch: Double, dist: Double, pulse: Double) {
        pitchArray.append(pitch)
        totalDistArray.append(dist)
        pulseArray.append(pulse)
//      print(self.pitchArray)
    }
    
    func onTrackForGoals(speedGoal: Double, timeGoal: Int) -> Bool {
        // return true or false if they are on track to meet workout goals
        var timeElapsed = totalDistArray.count * 5
        var currentSpeed = Double(totalDistArray.last!) / Double (timeElapsed)
        currentSpeedArray.append(currentSpeed)
       // print(timeElapsed)
       // print(currentSpeed)
     //   print(speedGoal)
        if (currentSpeed >= speedGoal) {
            onTrackForGoalsCounter += 1
            return true
        }
        return false
    }
    
    func getBackOnTrack() -> String {
        // return instructions for what the cyclist needs to do to get back on
        // track to meet their goals
        return "go faster"
    }
}
