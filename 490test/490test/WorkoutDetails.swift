//
//  WorkoutDetails.swift
//  490test
//
//  Created by Nicolas Spragg on 2017-11-22.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation
import UIKit

class WorkoutDetails: UIViewController {
    
    @IBAction func backbtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var recordedAtLable: UILabel!
    @IBOutlet weak var speedL: UILabel!
    
    @IBOutlet weak var hrl: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordedAtLable.text = " Recorded at: \(recordedAtList[position])"
        speedL.text = "Speed: \(speedList[position])"
        hrl.text = "Heartrate: \(heartRateList[position])"
        timeLabel.text = "Length of workout: \(timeList[position])"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        recordedAtLable.text = " Recorded at: \(recordedAtList[position])"
        speedL.text = "Speed: \(speedList[position])"
        hrl.text = "Heartrate: \(heartRateList[position])"
        timeLabel.text = "Length of workout: \(timeList[position])"
    }
}
