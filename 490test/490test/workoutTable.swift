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
var position = 0
class workoutTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToWorkoutDetail", sender: self)
        position = indexPath.row
    }
    
    
    // function fills in list of workouts with the timestamps in firebase
    func loadInList() {
        let uid = user?.uid
        ref = Database.database().reference()
        ref.child("workouts").child(uid!).observe(.childAdded) { (snapshot) in
            print(snapshot)
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
        if(loadCount == 0) {
            loadInList()
            loadCount += 1
        } else {
            print("already loaded")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool ) {
        tableView.reloadData()
    }
    
    
}
