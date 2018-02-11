//
//  loadingViewController.swift
//  490test
//
//  Created by Nicolas Spragg on 2017-11-25.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation
import UIKit

class LoadingViewController: UIViewController {
    var postWorkout = FinishedWorkoutManager()
    
    func uploadWorkout(){
        let averageSpeed = postWorkout.getAverageSpeed(speedArray: currentSpeedArray)
        let averagePulse = postWorkout.getAveragePulse(pulseArray: pulseArray)
        let averagePitch = postWorkout.getAveragePitch(pitchArray: pitchArray)
        postWorkout.pushFinishedWorkout(distance: totalDistArray.last ?? 0, averageSpeed: averageSpeed, averagePitch: averagePitch, averageHeartRate: averagePulse)
    }
    
    @IBOutlet weak var loadingBar: UIProgressView!
    
    @IBOutlet weak var userHelpLabel: UILabel!
    var progressTimer = Timer()
    @objc func progress() {
        loadingBar.progress += 0.05
        if(loadingBar.progress == 1) {
            userHelpLabel.text = "Done"
            self.performSegue(withIdentifier: "showCharts", sender: self)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        uploadWorkout()
        loadingBar.transform = loadingBar.transform.scaledBy(x: 1, y: 10)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(LoadingViewController.progress), userInfo: nil, repeats: true)
    }
}
