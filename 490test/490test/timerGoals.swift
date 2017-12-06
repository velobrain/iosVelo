//
//  timerGoals.swift
//  490test
//
//  Created by Nithan Kokulabalan on 2017-10-29.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class timerGoals: UIViewController {
    //Mark-----------Phone Sensor--------------------
    let phoneSensor = PhoneSensorManager()
    var pitch = 0.0
    var roll = 0.0
    var yaw = 0.0
    var inclinationCollection = [Double]()
    var sensorTimer: Timer!
    
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
    
    //Mark-----------Phone Sensor--------------------
    
    
    var ble: SimpleBluetoothIO!
    
    
    
    
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
    var timer = Timer()
    var minutes: Int = 0
    var seconds: Int = 0
    var startCountdown: Bool = true
    
  
    

    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func stopBtn(_ sender: Any) {
        timer.invalidate()
        startCountdown = false
        seconds = 0
        minutes = 0
        timeLbl.text = "\(minutes):\(seconds)"
    }
    
    @IBAction func stPa(_ sender: Any) {
        if startCountdown == true{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerGoals.updateCountdown), userInfo: nil, repeats: true)
            startCountdown = false
        }
    }
    
    //TODO: Fix -1:59 bug
    @objc func updateCountdown() {
        
        if(minutes == 0 && seconds == 0) {
            seconds = 0
            minutes = 0
            goToLoadingScreen()
            timeLbl.text = "\(minutes):\(seconds)"
            timer.invalidate()
            print("done workout")
            startCountdown = true
        }
        if seconds == 0 {
            minutes -= 1
            seconds = 60
        }
       
         seconds -= 1
        
        timeLbl.text = "\(minutes):\(seconds)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ble = SimpleBluetoothIO(serviceUUID: "6E400001-B5A3-F393-E0A9-E50E24DCCA9E", delegate: self)
        phoneSensor.startDeviceMotion()
        getSensorValues()
        speedG.text = speedP
        heartG.text = heartP
        timeG.text = timeP
        
        minutes = Int(timeP)!
      
        timeLbl.text = "\(timeP!):00"
        
        
        // Do any additional setup after loading the view.
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToLoadingScreen() {
        self.performSegue(withIdentifier: "goToLoadingScreen", sender: self)
    }
}

extension timerGoals: SimpleBluetoothIODelegate {
        func simpleBluetoothIO(simpleBluetoothIO: SimpleBluetoothIO, didReceiveValue value: Int8) {
                print(value)
                }
        }



