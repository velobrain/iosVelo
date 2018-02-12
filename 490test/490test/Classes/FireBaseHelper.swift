//
//  FireBaseHelper.swift
//  490test
//
//  Created by Nicolas Spragg on 2017-12-02.
//  Copyright © 2017 TBD. All rights reserved.
//
// Utility class for getting userID and reading/writing data to Firebase.
import Foundation
import Firebase

var name:String = ""
var height:String = ""
var weight:String = ""
var homeScreenDistance:Double = 0
var homeScreenPulse:Double = 0
var homeScreenSpeed:Double = 0
var homeScreenPitch:Double = 0

//Profile chart vars
var overallAverageSpeedList = [Double]()
var overallAveragePulseList = [Double]()
var overallWorkoutPerformanceList = [Double]()
class FireBaseHelper {
    var ref: DatabaseReference!
    
    init() {
        userNameAsync()
        userHeightAysnc()
        userWeightAsync()
        homeScreenDistanceAsync()
        homeScreenPulseAsync()
        homeScreenPitchAsync()
        homeScreenSpeedAsync()
        loadFinishedWorkouts()
    }
   
    //returns the current user's ID
    func getCurrentUserID() -> String? {
        return (Auth.auth().currentUser?.uid)!
    }
    
    func userNameAsync() {
        let uid = getCurrentUserID()
        print(uid!)
        ref = Database.database().reference()
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            name = value?["name"] as? String ?? ""
        })
    }
    
    func homeScreenDistanceAsync() {
        let uid = getCurrentUserID()
        ref = Database.database().reference()
        ref.child("finishedWorkouts").child(uid!).queryLimited(toLast: 1).observe(.childAdded) { (snapshot) in
            let value = snapshot.value as? NSDictionary
             homeScreenDistance = value?["Distance"] as? Double ?? 0
        }
    }
    
    func homeScreenPulseAsync() {
        let uid = getCurrentUserID()
        ref = Database.database().reference()
        ref.child("finishedWorkouts").child(uid!).queryLimited(toLast: 1).observe(.childAdded) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            homeScreenPulse = value?["averageHeartRate"] as? Double ?? 0
            homeScreenPulse = homeScreenPulse.rounded(toPlaces: 2)
        }
    }
    
    func homeScreenPitchAsync() {
        let uid = getCurrentUserID()
        ref = Database.database().reference()
        ref.child("finishedWorkouts").child(uid!).queryLimited(toLast: 1).observe(.childAdded) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            homeScreenPitch = value?["averagePitch"] as? Double ?? 0
            homeScreenPitch = homeScreenPitch.rounded(toPlaces: 2)
        }
    }
    
    func homeScreenSpeedAsync() {
        let uid = getCurrentUserID()
        ref = Database.database().reference()
        ref.child("finishedWorkouts").child(uid!).queryLimited(toLast: 1).observe(.childAdded) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            homeScreenSpeed = value?["averageSpeed"] as? Double ?? 0
            homeScreenSpeed = homeScreenSpeed.rounded(toPlaces: 2)
           
        }
    }
    
    

    func getUserName() -> String {
        return name
    }
    
    func userHeightAysnc() {
        let uid = getCurrentUserID()
        ref = Database.database().reference()
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            height = value?["height"] as? String ?? ""
        })
    }
    
    func getUserHeight() -> String {
        return height
    }
    
    
    func userWeightAsync(){
        let uid = getCurrentUserID()
        ref = Database.database().reference()
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            weight = value?["weight"] as? String ?? ""
        })
    }
    
    func getUserWeight() -> String {
        return weight
    }
    
    func loadFinishedWorkouts() {
        let uid = getCurrentUserID()
        ref = Database.database().reference()
        ref.child("finishedWorkouts").child(uid!).observe(.childAdded) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let averageSpeedToAppend = value?["averageSpeed"] as? Double ?? 0
            let averagePulseToAppend = value?["averageHeartRate"] as? Double ?? 0
            let workoutPerformanceToAppend = value?["Workout Performance"] as? Double ?? 0
            
            
            overallAverageSpeedList.append(averageSpeedToAppend)
            overallAveragePulseList.append(averagePulseToAppend)
            overallWorkoutPerformanceList.append(workoutPerformanceToAppend)
            
            
            
        }
    }
    
}


