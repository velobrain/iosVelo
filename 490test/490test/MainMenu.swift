//
//  MainMenu.swift
//  490test
//
//  Created by Nicolas Spragg on 2017-11-08.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MainMenu: UIViewController {
    
    var greeter = FireBaseHelper()
   
    @IBOutlet weak var greetLabel: UILabel!
    
    @IBAction func settingsButton(_ sender: Any) {
        performSegue(withIdentifier: "goToSettings", sender: self)
        
    }
    @IBAction func startWorkoutButton(_ sender: Any) {
        performSegue(withIdentifier:"goToWorkoutGoals" , sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let welcome = "Welcome back: "
        let name = greeter.getUserName()
         greetLabel.text = welcome + name
        
    }
    
    @IBAction func gotoLoginOrSignupButton(_ sender: Any) {
        performSegue(withIdentifier: "goToNewLoginPage", sender: self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
