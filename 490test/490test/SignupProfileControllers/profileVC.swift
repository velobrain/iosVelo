//
//  profileVC.swift
//  490test
//
//  Created by Nithan Kokulabalan on 2017-11-22.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import LinearProgressView

class profileVC: UIViewController {
     @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var test: LinearProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.setProgress(0.6, animated: true)
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 5)
        self.progressBar.layer.cornerRadius = 15
        self.progressBar.clipsToBounds = true
        
        self.progressBar.layer.sublayers![1].cornerRadius = 15
        self.progressBar.subviews[1].clipsToBounds = true
      //  progressBar.increaseSize(2)
        //progressBar.increaseSize(50);cr
        

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

