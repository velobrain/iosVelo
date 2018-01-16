//
//  WorkoutGoals.swift
//  490test
//
//  Created by Nithan Kokulabalan on 2017-10-29.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import Firebase


class WorkoutGoals: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var placeHolder: UILabel!
    
    @IBOutlet weak var placeHolder2: UILabel!
    @IBOutlet weak var placeHolder3: UILabel!
    @IBOutlet weak var placeHolder4: UILabel!
    
    @IBOutlet weak var speedIn: UITextField!
    
    @IBOutlet weak var heartIn: UITextField!
    
    @IBOutlet weak var timeIn: UITextField!
    
    @IBOutlet weak var weightIn: UITextField!
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openModal(_ sender: Any) {
        pushWorkout()
        print("Button has been pressed")
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        placeHolder.text = speedIn.text
        placeHolder2.text = heartIn.text
        placeHolder3.text = timeIn.text
        placeHolder4.text = weightIn.text
    }
    
    //removes the keyboard by tapping anywhere on screen
    func removeKB() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goalsNext"){
            let  myVC = segue.destination as! timerGoals
            myVC.timeP = timeIn.text!
            myVC.heartP = heartIn.text!
            myVC.speedP = speedIn.text!
        }
    }
    
    func pushWorkout() {
        let speed = speedIn.text
        let heartRate = heartIn.text
        let time = timeIn.text
        let userID = Auth.auth().currentUser?.uid
    
        let ref = Database.database().reference(fromURL: "https://velobrain-f3c9d.firebaseio.com/")
        //let userRef = ref.child("users").child(userID)
        //let workoutref = userRef.childByAutoId()
    
        
        let today : String!
        
        today = getTodayString()
        
        let workoutref = ref.child("workouts").child(userID!).child(today);
         let recordedAt = today
        let workoutValues = ["speed" : speed, "heartRate" : heartRate, "time" : time, "recordedAt" : recordedAt]
        
        workoutref.updateChildValues(workoutValues, withCompletionBlock: { (err, ref) in
            if err != nil {
                print(err!)
                return
            }
            print("added workout to db")
        })
        
    }
    
    func getTodayString() -> String{
        
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        
        return today_string
        
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speedIn.delegate = self
        heartIn.delegate = self
        timeIn.delegate = self
        weightIn.delegate = self
        removeKB()
    }
    
   


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}





