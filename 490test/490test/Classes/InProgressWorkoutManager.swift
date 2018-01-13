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
class InProgessWorkoutManager {
    var pitchArray: [Double]
    var totalDistArray: [Double]
    var pulseArray: [Double]
    
    init() {
        self.pitchArray = []
        self.totalDistArray = []
        self.pulseArray = []
    }
    
    func newEntry(pitch: Double, dist: Double, pulse: Double) {
        self.pitchArray.append(pitch)
        self.pitchArray.append(dist)
        self.pitchArray.append(pulse)
        print(self.pitchArray)
    }
    
    func onTrackForGoals() -> Bool {
        // return true or false if they are on track to meet workout goals
        return true
    }
    
    func getBackOnTrack() -> String {
        // return instructions for what the cyclist needs to do to get back on
        // track to meet their goals
        return "go faster"
    }
}
