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
class FireBaseHelper {
    var ref: DatabaseReference!
    
    
    
    
    init() {
        userNameAsync()
        userHeightAysnc()
        userWeightAsync()
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
    
}
