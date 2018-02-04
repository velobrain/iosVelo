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
   
    @IBOutlet weak var leftTopBox: UILabel!
    @IBOutlet weak var leftBottomBox: UILabel!
    @IBOutlet weak var rightTopBox: UILabel!
    @IBOutlet weak var rightBottomBox: UILabel!
    @IBOutlet weak var greetLabel: UILabel!
    @IBOutlet weak var startWorkoutButtonLbl: UIButton!
    @IBOutlet weak var proffileButtonLbl: UIButton!
    
    
    
    
    @IBAction func settingsButton(_ sender: Any) {
        performSegue(withIdentifier: "goToSettings", sender: self)
        
    }
    @IBAction func startWorkoutButton(_ sender: Any) {
        performSegue(withIdentifier:"goToWorkoutGoals" , sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bordersForBoxes()
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let name = greeter.getUserName()
         greetLabel.text = name
        
    }
    
    @IBAction func gotoLoginOrSignupButton(_ sender: Any) {
        performSegue(withIdentifier: "goToNewLoginPage", sender: self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bordersForBoxes(){
        leftTopBox.layer.addBorder(edge: UIRectEdge.right, color: UIColor.black, thickness: 1.5)
        leftTopBox.layer.addBorder(edge: UIRectEdge.top, color: UIColor.black, thickness: 1.5)
        leftTopBox.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.black, thickness: 1.5)
        leftBottomBox.layer.addBorder(edge: UIRectEdge.right, color: UIColor.black, thickness: 1.5)
        leftBottomBox.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.black, thickness: 1.5)
        rightTopBox.layer.addBorder(edge: UIRectEdge.top, color: UIColor.black, thickness: 1.5)
        rightTopBox.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.black, thickness: 1.5)
        rightBottomBox.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.black, thickness: 1.5)
        
    
    }
    
    

}

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            //For Center Line
            border.frame = CGRect(x: self.frame.width/2 - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        }
        
        border.backgroundColor = color.cgColor;
        self.addSublayer(border)
    }
}
