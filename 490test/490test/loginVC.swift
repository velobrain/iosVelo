//
//  loginVC.swift
//  490test
//
//  Created by Nithan Kokulabalan on 2017-11-12.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import Firebase

class loginVC: UIViewController {

    @IBAction func signUpBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "signUp", sender: nil)
    }
    @IBOutlet weak var userNameLbl: UITextField!
    @IBOutlet weak var pwLbl: UITextField!
    @IBOutlet weak var loginBtnShape: UIButton!
    @IBOutlet weak var signBtnSHape: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBAction func loginBtn(_ sender: Any) {
        login()
    }
    @IBAction func pwForBtn(_ sender: Any) {
    }
    
  
    
    
    
    override func viewDidLoad() {
         self.removeKB()
        self.hidePWFields()
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "loginSuccess", sender: nil)
            } else {
                self.cornersColours()
               
                super.viewDidLoad()
            }
        }
        
        
        // Do any additional setup after loading the view.
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
    
    
    func login (){
        guard let emailLogin = userNameLbl.text else {
            print ("invaild input")
            return
        }
        
        guard let pwLogin = pwLbl.text else {
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
            self.performSegue(withIdentifier: "loginSuccess", sender: nil)
        }
    }
    
    
    func cornersColours(){
        pwLbl.layer.cornerRadius = 20.0
        pwLbl.clipsToBounds = true
        userNameLbl.layer.cornerRadius = 20.0
        userNameLbl.clipsToBounds = true
        loginBtnShape.layer.cornerRadius = 20.0
        loginBtnShape.clipsToBounds = true
        signBtnSHape.layer.cornerRadius = 20.0
        signBtnSHape.clipsToBounds = true
    }
    
    func hidePWFields(){
        pwLbl.isSecureTextEntry = true
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
