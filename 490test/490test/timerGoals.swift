//
//  timerGoals.swift
//  490test
//
//  Created by Nithan Kokulabalan on 2017-10-29.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class timerGoals: UIViewController {
    
    let phoneSensor = PhoneSensorManager()
    
    var pitch = 0.0
    var roll = 0.0
    var yaw = 0.0
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var speedG: UILabel!
    @IBOutlet weak var heartG: UILabel!
    @IBOutlet weak var timeG: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var stPaLbl: UIButton!
    @IBOutlet weak var stopLbl: UIButton!
    var timeP:String!
    var speedP:String!
    var heartP:String!
    
    var counter = 0.0
    var timer = Timer()
    var sensorTimer: Timer!
    var isPlaying = false
    var count: Int = 0
    var inclinationCollection = [Double]()
    
    func getSensorValues() {
        self.sensorTimer = Timer(fire: Date(), interval: (1.0/5.0), repeats: true, block: { (sensorTimer) in
            self.phoneSensor.startDeviceMotion()
            self.pitch = self.phoneSensor.getPitch()
            self.roll = self.phoneSensor.getRoll()
            self.yaw = self.phoneSensor.getYaw()
            self.inclinationCollection.append(self.pitch)
                
        })
        RunLoop.current.add(self.sensorTimer!, forMode: .defaultRunLoopMode)
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneSensor.startDeviceMotion()
        getSensorValues()
        speedG.text = speedP
        heartG.text = heartP
        timeG.text = timeP
        timeLbl.text = String(counter)
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func stopBtn(_ sender: Any) {
    }
    
    @IBAction func stPa(_ sender: Any) {
        if (!isPlaying){
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerGoals.UpdateTimer), userInfo: nil, repeats: true)
            
        }
        else{
            timer.invalidate()
            isPlaying = false
        }
        
        
    }
    
    @objc func UpdateTimer(){
        counter = counter + 0.1
        timeLbl.text = String(format: "%.lf",counter)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



