//
//  FakeDataGenerator.swift
//  490test
//
//  Created by Nicolas Spragg on 2018-01-30.
//  Copyright © 2018 TBD. All rights reserved.
//

import Foundation
class FakeDataGenerator {
    
    func genRandomDistance(previousDistance: Double) -> Double {
        return Double(arc4random_uniform(10)) + Double(previousDistance)
    }
    
    func genRandomPulse() -> Double {
        return Double(arc4random_uniform(150)) + 80
    }
    
    func genRandomPitch() -> Double{
        return Double(arc4random()) / Double(UInt32.max)
    }
}
