//
//  workoutTable.swift
//  490test
//
//  Created by Nicolas Spragg on 2017-11-22.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation
import UIKit

class workoutTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    let list = ["temp1" , "temp2" , "temp3"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "workoutCell")
        cell.textLabel?.text = list[indexPath.row]
        return cell
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
