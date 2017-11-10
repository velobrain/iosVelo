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
    
    
    @IBAction func loginButton(_ sender: Any) {
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
        
        Auth.auth().createUser(withEmail: emailReg, password: passwordReg, completion: { (user,error) in
            print(emailReg)
            if error != nil {
                print(error!)
                return
            }
            // made new authenticated user
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
