//
//  loadingViewController.swift
//  490test
//
//  Created by Nicolas Spragg on 2017-11-25.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation
import UIKit

class LoadingViewController: UIViewController {
    
    
    @IBOutlet weak var loadingBar: UIProgressView!
    
    @IBOutlet weak var userHelpLabel: UILabel!
    var progressTimer = Timer()
    
    @objc func progress() {
        loadingBar.progress += 0.005
        
        if(loadingBar.progress == 1) {
            userHelpLabel.text = "Done"
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingBar.transform = loadingBar.transform.scaledBy(x: 1, y: 10)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(LoadingViewController.progress), userInfo: nil, repeats: true)
    }
}
