//
//  splashController.swift
//  490test
//
//  Created by Nicolas Spragg on 2018-02-05.
//  Copyright © 2018 TBD. All rights reserved.
//

import Foundation

import UIKit
import Firebase

class splashController: UIViewController {
    @IBOutlet weak var gifView: UIImageView!
    
    @objc func jumpToNextViewAfterLoad() {
        performSegue(withIdentifier: "splashToLogin", sender: self)
    }
    
    @objc func skipToMenuAlreadyLoggedIn() {
        performSegue(withIdentifier: "skipToMenu", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gifView.loadGif(name: "ring")
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                let firebaseData = FireBaseHelper();
                self.perform(#selector(self.skipToMenuAlreadyLoggedIn), with: nil, afterDelay: 2)
            } else {
                self.perform(#selector(self.jumpToNextViewAfterLoad), with: nil, afterDelay: 2)
            }
        }
    }
    
    
}
