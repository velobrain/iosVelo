//
//  PhoneSensorManager.swift
//  490test
//
//  Created by Nicolas Spragg on 2017-11-24.
//  Copyright © 2017 TBD. All rights reserved.
//

/**
 * This class sets up the built in accelorometers and provides getters for the data
 * to be used in other classes
 */

import Foundation
import CoreMotion

public class PhoneSensorManager {
    
    let motion = CMMotionManager()
    var timer: Timer!
    
    var x: Double
    var y: Double
    var z: Double
    
    init() {
        self.x = 0.0
        self.y = 0.0
        self.z = 0.0
    }
    
    func startDeviceMotion() {
        if motion.isDeviceMotionAvailable {
            self.motion.deviceMotionUpdateInterval = 1.0 / 5.0
            self.motion.showsDeviceMovementDisplay = true
            self.motion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            self.timer = Timer(fire: Date(), interval: (1.0/5.0), repeats: true, block: { (timer) in
                if let data = self.motion.deviceMotion {
                    self.x = data.attitude.pitch
                    self.y = data.attitude.roll
                    self.z = data.attitude.yaw
                }
            })
            
            RunLoop.current.add(self.timer!, forMode: .defaultRunLoopMode)
        }
    }
    
    func getPitch() -> Double {
        return x
    }
    
    func getRoll() -> Double {
        return y
    }
    
    func getYaw() -> Double {
        return z
    }
    
    
    
    
    
}
