
//
//  signupVC.swift
//  490test
//
//  Created by Nithan Kokulabalan on 2017-11-12.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import Firebase

class signupVC: UIViewController {

    @IBOutlet weak var pwRegField: UITextField!
    @IBOutlet weak var emailRegField: UITextField!
    @IBOutlet weak var nameRegField: UITextField!
    @IBOutlet weak var ageRegField: UITextField!
    @IBOutlet weak var weightRegField: UITextField!
    @IBOutlet weak var hieghtRegField: UITextField!
    @IBOutlet weak var regBtnShape: UIButton!
    //MARK
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        register()
    }
    
    
    func register() {
        guard let emailReg = emailRegField.text else {
            // Change this to an alert view later
            print("Invalid Input")
            return
        }
        
        guard let passwordReg = pwRegField.text else {
            // Change this to an alert view later
            print("Invalid Input")
            return
        }
        
        guard let name = nameRegField.text else {
            // Change this to an alert view later
            print("Invalid Input")
            return
        }
        
        guard let age = ageRegField.text else {
            // Change this to an alert view later
            print("Invalid Input")
            return
        }
        
        guard let weight = weightRegField.text else {
            // Change this to an alert view later
            print("Invalid Input")
            return
        }
        
        guard let height = hieghtRegField.text else {
            // Change this to an alert view later
            print("Invalid Input")
            return
        }
        
        
        
        Auth.auth().createUser(withEmail: emailReg, password: passwordReg, completion: { (user,error) in
            print(emailReg)
            if error != nil {
                print(error!)
                let alert = UIAlertController(title: "Error", message: "Invalid Information", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title:"OK",style: UIAlertActionStyle.default, handler:nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            // made new authenticated user
            guard let uid = user?.uid else {
                return
            }
            let ref = Database.database().reference(fromURL: "https://velobrain-f3c9d.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            let values = ["name": name, "email" : emailReg, "age" : age, "weight" : weight, "height" : height]
            
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err!)
                    return
                }
                print("saved successfully to DB")
                
            })
            
            self.performSegue(withIdentifier: "signUpSucess", sender: nil)
            
            
            
        })
        
        
        
    }
    
    func cornersColours(){
        pwRegField.layer.cornerRadius = 20.0
        pwRegField.clipsToBounds = true
        emailRegField.layer.cornerRadius = 20.0
        emailRegField.clipsToBounds = true
        nameRegField.layer.cornerRadius = 20.0
        nameRegField.clipsToBounds = true
        ageRegField.layer.cornerRadius = 20.0
        ageRegField.clipsToBounds = true
        weightRegField.layer.cornerRadius = 20.0
        weightRegField.clipsToBounds = true
        hieghtRegField.layer.cornerRadius = 20.0
        hieghtRegField.clipsToBounds = true
        regBtnShape.layer.cornerRadius = 20.0
        regBtnShape.clipsToBounds = true
        
        
    }
    
    
    override func viewDidLoad() {
        cornersColours()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
