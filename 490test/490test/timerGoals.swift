//
//  timerGoals.swift
//  490test
//
//  Created by Nithan Kokulabalan on 2017-10-29.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
var debugMode = 0; // 1 = debug
class timerGoals: UIViewController {
    //Mark-----------Phone Sensor--------------------
    let phoneSensor = PhoneSensorManager()
    let currentWorkout = InProgessWorkoutManager()
    var pitch = 0.0
    var speedGoal = 0.0
    var pulseGoal = 0.0
    var timeGoal = 0
    let topics = ["pulse", "speed", "distance", "pitch", "calories", "time"]
    var topicIndex = 0
    
   
    //Mark--------------DEBUG-------------------------------
    
     var fakeData = FakeDataGenerator()
    var fakeDataTimer: Timer!
    func genFakeData() {
        self.fakeDataTimer = Timer(fire: Date(), interval: (0.33), repeats: true, block: { (fakeDataTimer) in
            self.currentWorkout.newEntry(pitch: self.fakeData.genRandomPitch(), dist: self.fakeData.genRandomDistance(previousDistance: totalDistArray.last ?? 0)) // pitch and distance
            self.currentWorkout.newEntryPulse(pulse: self.fakeData.genRandomPulse()) // pulse
            
            self.currentWorkout.onTrackForGoals(speedGoal: self.speedGoal, timeGoal: self.timeGoal)
            self.currentWorkout.newEntryPulse(pulse: self.pulseGoal)
            print(currentSpeedArray)
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
        if(debugMode == 1) {
            fakeDataTimer.invalidate()
        }
        sensorTimer.invalidate()
    }
    
    
    @IBAction func stopBtn(_ sender: Any) {
        timer.invalidate()
        if(debugMode == 1 ){
             fakeDataTimer.invalidate()
        }
        disconnectFromBluetooth()
        goToLoadingScreen()
        
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
                if(debugMode == 1) {
                    genFakeData()
                }
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
        self.speedGoal = Double(speedP)! / 60
        self.pulseGoal = Double(heartP)!
        self.timeGoal = Int(timeP)!
        ble = SimpleBluetoothIO(serviceUUID: "6E400001-B5A3-F393-E0A9-E50E24DCCA9E", delegate: self)
        phoneSensor.startDeviceMotion()
        getSensorValues()
        speedG.text = "Speed Goal: " + speedP
        heartG.text = "Heart Rate Goal: " + heartP
        //timeG.text = timeP
        
        minutes = Int(timeP)!
      
        timeLbl.text = "\(timeP!):00"
        
       
        
    
        // Do any additional setup after loading the view.
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToLoadingScreen() {
        self.speech.talkCustom(phrase:" workout complete. check your stats")
        disconnectFromBluetooth()
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
    
    func saySomething(topic: String) {
        switch topic {
        case "pulse":
            if (self.currentWorkout.onTrackForGoalsPulse(pulseGoal: pulseGoal)) {
                speech.talkCustom(phrase: "You are on track for your pulse goals. Pulse is \(Double(currentAveragePulse).rounded(toPlaces: 2))")
            } else {
                speech.talkCustom(phrase: "Try harder. Pulse is \(Double(currentAveragePulse).rounded(toPlaces: 2)) ")
            }
        case "speed":
            if (self.currentWorkout.onTrackForGoals(speedGoal: Double(speedGoal), timeGoal: timeGoal)) {
                
                speech.talkCustom(phrase: "You are on track for your speed goals your speed is \(Double(currentSpeedArray.last! * 60).rounded(toPlaces: 2)) kilometres per hour")
            } else {
                speech.talkCustom(phrase: "You are not on track for your speed goals. your speed is \(Double(currentSpeedArray.last! * 60).rounded(toPlaces: 2)) kilometres per hour")
            }
        case "distance":
            speech.talkCustom(phrase: "Your total distance is \(Double(totalDistArray.last!)/1000.rounded(toPlaces: 2)) kilometres")
        case "pitch":
            speech.talkCustom(phrase: "Your pitch is \(Double(pitchArray.last!).rounded(toPlaces: 2))")
        case "calories":
            // 5.5 is the MET value for active bicycling
            let calories = ( ( 0.0175 * 5.5 * (Double(weight))! ) / 60 ) * Double( totalDistArray.count * 5 )
            speech.talkCustom(phrase: "You have burned \(calories.rounded(toPlaces: 2)) calories")
        case "time":
            speech.talkCustom(phrase: "You have been cycling for \(Double(totalDistArray.count)*5) seconds")
        default:
            //do nothing
            print("")
        }
    }
   
}// end class



extension timerGoals: SimpleBluetoothIODelegate {
        func simpleBluetoothIO(simpleBluetoothIO: SimpleBluetoothIO, didReceiveValue value: Int8) {
    
            if(value  > 0 ) {
              self.currentWorkout.newEntry(pitch: self.pitch, dist: Double(value))
                print("total distance")
                print(totalDistArray)
                topicIndex += 1
                if (topicIndex == 5) { topicIndex = 0}
            } else {
                self.currentWorkout.newEntryPulse(pulse: Double(-value))
                print("pulse array")
                print(pulseArray)
            }
            
            // happens every 10 seconds and only on positive bluetooth values
            if(totalDistArray.count % 2 == 0 && value > 0) {
                saySomething(topic: topics[topicIndex])
            }
            
        }
           
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}









