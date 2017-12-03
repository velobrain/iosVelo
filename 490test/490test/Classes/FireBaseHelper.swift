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

class FireBaseHelper {
    var ref: DatabaseReference!
    
    //returns the current user's ID
    func getCurrentUserID() -> String? {
        return (Auth.auth().currentUser?.uid)!
    }
    
    func getUserName() -> String {
        let uid = getCurrentUserID()
        var name:String = ""
        ref = Database.database().reference()
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
             name = value?["name"] as? String ?? ""
        })
        return name
    }
    
    func getUserHeight() -> String {
        let uid = getCurrentUserID()
        var height:String = ""
        ref = Database.database().reference()
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            height = value?["height"] as? String ?? ""
        })
        return height
    }
    
    func getUserWeight() -> String {
        let uid = getCurrentUserID()
        var weight:String = ""
        ref = Database.database().reference()
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            weight = value?["weight"] as? String ?? ""
        })
        return weight
    }
    
}
