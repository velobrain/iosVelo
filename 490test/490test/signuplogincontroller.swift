//
//  signupcontroller.swift
//  490test
//
//  Created by Nicolas Spragg on 2017-11-09.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class signuplogincontroller: UIViewController {
    //MARK - Login Fields
    @IBOutlet weak var emailLoginField: UITextField!
    @IBOutlet weak var pwloginfield: UITextField!
    // MARK
    
    //MARK - Register Fields
   
    @IBOutlet weak var pwRegField: UITextField!
    @IBOutlet weak var emailRegField: UITextField!
    @IBOutlet weak var nameRegField: UITextField!
    @IBOutlet weak var ageRegField: UITextField!
    @IBOutlet weak var weightRegField: UITextField!
    @IBOutlet weak var hieghtRegField: UITextField!
    //MARK
    
    @IBAction func backButton(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        login()
    }
    
    
    @IBAction func registerButton(_ sender: Any) {
        register()
    }
    
    func login (){
        guard let emailLogin = emailLoginField.text else {
            print ("invaild input")
            return
        }
        
        guard let pwLogin = pwloginfield.text else {
            print ("Invaild Input")
            return
        }
        
        Auth.auth().signIn(withEmail: emailLogin, password: pwLogin){(user,error) in
            print (emailLogin)
            if error != nil {
                let alert = UIAlertController(title: "Error", message: "Invalid Password or Username.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title:"OK",style: UIAlertActionStyle.default, handler:nil))
                self.present(alert, animated: true, completion: nil)
                print(error!)
                return
            }
            
            print ("I logged in somehow")
        }
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
            
            
            
        })

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeKB()
    }
    
    func removeKB() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
