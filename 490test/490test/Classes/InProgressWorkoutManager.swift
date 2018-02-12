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
var currentAveragePulse : Double = 0
var currentAverageSpeed : Double = 0
class InProgessWorkoutManager {
    
    
    init() {
        pitchArray = []
        totalDistArray = []
        pulseArray = []
    }
    
    func newEntryPulse(pulse: Double) {
        pulseArray.append(pulse)
    }
    
    func newEntry(pitch: Double, dist: Double) {
        pitchArray.append(pitch)
        totalDistArray.append(dist)
    }
    
    func onTrackForGoals(speedGoal: Double, timeGoal: Int) -> Bool {
        // return true or false if they are on track to meet workout goals
        var timeElapsed = Double(totalDistArray.count) * 5
        var currentSpeed = Double(totalDistArray.last!) / Double (timeElapsed)
        currentSpeedArray.append(currentSpeed)
        if (currentSpeed >= speedGoal) {
            onTrackForGoalsCounter += 1
            return true
        }
        return false
    }
    
func onTrackForGoalsPulse(pulseGoal: Double) -> Bool {
      var timeElapsed = totalDistArray.count * 5
    var averageHeartRate = pulseArray.last! / Double (timeElapsed)
    averageHeartRate *= 60 // times 60 to make it in bpm
    currentAveragePulse = averageHeartRate
    if (averageHeartRate >= pulseGoal) {
        onTrackForGoalsCounter += 1
        return true
    } else {
        return false
    }
    
}
    
    func getBackOnTrack() -> String {
        // return instructions for what the cyclist needs to do to get back on
        // track to meet their goals
        return "go faster"
    }
}
