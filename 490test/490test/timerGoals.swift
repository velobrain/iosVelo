//
//  timerGoals.swift
//  490test
//
//  Created by Nithan Kokulabalan on 2017-10-29.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
var debugMode = 1; // 1 = debug
class timerGoals: UIViewController {
    //Mark-----------Phone Sensor--------------------
    let phoneSensor = PhoneSensorManager()
    let currentWorkout = InProgessWorkoutManager()
    var pitch = 0.0
    var speedGoal = 0.0
    var timeGoal = 0
    
   
    //Mark--------------DEBUG-------------------------------
     var fakeData = FakeDataGenerator()
    var fakeDataTimer: Timer!
    func genFakeData() {
        self.fakeDataTimer = Timer(fire: Date(), interval: (5.0), repeats: true, block: { (fakeDataTimer) in
            self.currentWorkout.newEntry(pitch: self.fakeData.genRandomPitch(), dist: self.fakeData.genRandomDistance(previousDistance: totalDistArray.last ?? 0) , pulse: self.fakeData.genRandomPulse())
        })
        RunLoop.current.add(self.fakeDataTimer!, forMode: .defaultRunLoopMode)
    }
    //--------------------------------------------------------
    
    

    var sensorTimer: Timer!
    
    func getSensorValues() {
        self.sensorTimer = Timer(fire: Date(), interval: (1.0/5.0), repeats: true, block: { (sensorTimer) in
            self.phoneSensor.startDeviceMotion()
            self.pitch = self.phoneSensor.getPitch()
        })
        RunLoop.current.add(self.sensorTimer!, forMode: .defaultRunLoopMode)
    }
    
    //Mark-----------Phone Sensor--------------------
    
    
    var ble: SimpleBluetoothIO!
     var speech = TextToSpeech()
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var speedG: UILabel!
    @IBOutlet weak var heartG: UILabel!
    //@IBOutlet weak var timeG: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var stPaLbl: UIButton!
    @IBOutlet weak var stopLbl: UIButton!
    @IBOutlet weak var bleConnectionStatusLbl: UILabel!
    var timeP:String!
    var speedP:String!
    var heartP:String!
    var timer = Timer()
    var minutes: Int = 0
    var seconds: Int = 0
    var startCountdown: Bool = true
    
    @IBAction func backBtn(_ sender: Any) {
        disconnectFromBluetooth()
        dismiss(animated: true, completion: nil)
        fakeDataTimer.invalidate()
        sensorTimer.invalidate()
    }
    
    
    @IBAction func stopBtn(_ sender: Any) {
        timer.invalidate()
        fakeDataTimer.invalidate()
        sensorTimer.invalidate()
        startCountdown = false
        seconds = 0
        minutes = 0
        timeLbl.text = "\(minutes):\(seconds)"
    }
    
    @IBAction func stPa(_ sender: Any) {
        if (!ble.connectedToDevice && debugMode == 0) {
            let alert = UIAlertController(title: "No Connection Error", message: "Please wait for connection", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title:"OK",style: UIAlertActionStyle.default, handler:nil))
            self.present(alert, animated: true, completion: nil)
            print("not connected yet")
        } else {
            if startCountdown == true{
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerGoals.updateCountdown), userInfo: nil, repeats: true)
                startCountdown = false
            }
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
        bleConnectionStatusLbl.text = "Bluetooth Connection Status: Not Connected"
        self.speedGoal = Double(speedP)! / 60
        self.timeGoal = Int(timeP)!
        ble = SimpleBluetoothIO(serviceUUID: "6E400001-B5A3-F393-E0A9-E50E24DCCA9E", delegate: self)
        phoneSensor.startDeviceMotion()
        getSensorValues()
        speedG.text = "Speed Goal: " + speedP
        heartG.text = "Heart Rate Goal: " + heartP
        //timeG.text = timeP
        
        minutes = Int(timeP)!
      
        timeLbl.text = "\(timeP!):00"
        
        if(debugMode == 1) {
            genFakeData()
        }
        
    
        // Do any additional setup after loading the view.
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToLoadingScreen() {
        self.performSegue(withIdentifier: "goToLoadingScreen", sender: self)
    }
    
    
    
    func disconnectFromBluetooth() {
        if  ble.connectedPeripheral != nil {
            print("diconnected sucessfully")
            ble.centralManager.cancelPeripheralConnection(ble.connectedPeripheral!)
            ble.connectedToDevice = false
        } else {
            print("error disconnecting - no device was connected")
        }
    }
   
}// end class



extension timerGoals: SimpleBluetoothIODelegate {
        func simpleBluetoothIO(simpleBluetoothIO: SimpleBluetoothIO, didReceiveValue value: Int8) {
            print(value)
            
            self.currentWorkout.newEntry(pitch: self.pitch, dist: Double(value), pulse: Double(value))
            if (self.currentWorkout.onTrackForGoals(speedGoal: Double(speedGoal), timeGoal: timeGoal)) {
                speech.talkCustom(phrase: "You are on track for your goals")
            }
            else {
                speech.talkCustom(phrase: "You are not on track for your goals")
            }
                
        }
}






