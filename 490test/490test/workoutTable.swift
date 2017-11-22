//
//  workoutTable.swift
//  490test
//
//  Created by Nicolas Spragg on 2017-11-22.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation
import UIKit
import Firebase

var recordedAtList = [String]()
var heartRateList = [String]()
var speedList = [String]()
var timeList = [String]()
class workoutTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser
    
    
    
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(recordedAtList.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "workoutCell")
        cell.textLabel?.text = recordedAtList[indexPath.row]
        return cell
        
    }
    
    
    // function fills in list of workouts with the timestamps in firebase
    func loadInList() {
        let uid = user?.uid
        ref = Database.database().reference()
        ref.child("workouts").child(uid!).observe(.childAdded) { (snapshot) in
        
            let value = snapshot.value as? NSDictionary
            let valueToAppend = value?["recordedAt"] as? String ?? ""
            let heartRateToAppend = value?["heartRate"] as? String ?? ""
            let speedToAppend = value?["speed"] as? String ?? ""
            let timeToAppend = value?["time"] as? String ?? ""
            recordedAtList.append(valueToAppend)
            heartRateList.append(heartRateToAppend)
            speedList.append(speedToAppend)
            timeList.append(timeToAppend)
            
        }
      
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInList()
    }
    
    
}
