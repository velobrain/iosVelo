//
//  WorkoutAnalyzer.swift
//  490test
//
//  Created by Nicolas Spragg on 2017-11-25.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation
import Firebase
// class for post workout analyis chart view will use this class to show results and compare against goals
class FinishedWorkoutManager{
    var ref: DatabaseReference!
    
    func getAverageSpeed (speedArray :[Double]) -> Double {
        return (speedArray.reduce(0,+) / Double(speedArray.count))
    }
    
    func getAveragePulse (pulseArray :[Double]) -> Double {
        return (pulseArray.reduce(0,+) / Double(pulseArray.count))
    }
    
    func getAveragePitch (pitchArray :[Double]) -> Double {
        var pitch =  (pitchArray.reduce(0,+) / Double(pitchArray.count))
        // convert to degrees
        var degrees = pitch * (180/M_PI)
        return degrees
    }
    
    
    func pushFinishedWorkout(distance :Double, averageSpeed :Double, averagePitch :Double, averageHeartRate :Double ) {
        var workoutPerformance : Double
        guard let userID = Auth.auth().currentUser?.uid else {
            print ("something went wrong")
            return
        }
        if(debugMode == 1) {
            var fakeStat : Double = Double(arc4random_uniform(UInt32(totalDistArray.count))) + 1
             workoutPerformance = fakeStat / Double(totalDistArray.count)
        } else {
            workoutPerformance = onTrackForGoalsCounter / Double(totalDistArray.count)
        }
        
        ref = Database.database().reference().child("finishedWorkouts").child(userID).childByAutoId()
        let time: String!
        time = getTodayString()
        let valuesToPush = ["Distance" : distance, "averageSpeed" : averagePitch, "averagePitch" : averagePitch, "averageHeartRate" :averageHeartRate, "dateCompleted" : time, "Workout Performance" : workoutPerformance] as [String : Any]
        
        ref.updateChildValues(valuesToPush) { (err, ref) in
            if err != nil {
                print(err!)
                return
            }
            print("finished workout added to DB")
        }

    }
    

    func getTodayString() -> String{
        
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        
        return today_string
        
    }
    
    
   
} // end of class

