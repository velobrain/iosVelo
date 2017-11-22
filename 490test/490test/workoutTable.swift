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

class workoutTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser
    
    
    
    
    var list = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "workoutCell")
        cell.textLabel?.text = list[indexPath.row]
        return cell
        
    }
    
    
    // function fills in list of workouts with the timestamps in firebase
    func loadInList() {
        let uid = user?.uid
        ref = Database.database().reference()
        ref.child("workouts").child(uid!).observe(.childAdded) { (snapshot) in
        
            let value = snapshot.value as? NSDictionary
            let valueToAppend = value?["recordedAt"] as? String ?? ""
            self.list.append(valueToAppend)
            print(self.list)
        }
      
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInList()
    }
    
    
}
