//
//  ViewController.swift
//  490test
//
//  Created by Nithan Kokulabalan on 2017-10-29.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btn1: UIButton!
  
    @IBAction func btn1(_ sender: Any) {
        print("Button 1 is pressed")
        btn1.setTitle("Connected", for: .normal)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

