//
//  ProfileController.swift
//  490test
//
//  Created by Nicolas Spragg on 2017-11-09.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ProfileController: UIViewController {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userHeightLbl: UILabel!
    @IBOutlet weak var userWeightLbl: UILabel!
    @IBOutlet weak var loggedIn: UILabel!
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        isLoggedIn()
        super.viewDidLoad()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
            signOutUser()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    // checks if the user is logged in
    func isLoggedIn(){
        if user != nil {
            profileInfo()
        }
        else {
            print("no one logged in")
            loggedIn.text = "Login first"
        }
    }
    
    func signOutUser(){
        let auth = Auth.auth()
        do {
            try auth.signOut()
        }catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
                
            
        }
    }
    
    func profileInfo(){
        let uid = user?.uid
        ref = Database.database().reference()
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            self.userNameLbl.text = value?["name"] as? String ?? ""
            self.userHeightLbl.text = value?["height"] as? String ?? ""
            self.userWeightLbl.text = value?["weight"] as? String ?? ""
        })
        
        
    }
    
    
    
}
