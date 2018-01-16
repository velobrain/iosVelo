//
//  TextToSpeech.swift
//  490test
//
//  Created by Nicolas Spragg on 2018-01-13.
//  Copyright © 2018 TBD. All rights reserved.
//

import Foundation
import AVFoundation


// Handles giving instructions to the user
class TextToSpeech {

    let voice = AVSpeechSynthesizer()
    var coachingTipsArray : [String] = []

    

    init() {
        // add more options
        coachingTipsArray  = ["test", "You are slow", "You are fast" , "Good job", "do you know the wae"]
    }

    func talk(id: Int) {
        var sayThis = AVSpeechUtterance(string: coachingTipsArray[id])
        voice.speak(sayThis)
    }
    
    func talkCustom(phrase: String) {
        voice.speak(AVSpeechUtterance(string: phrase))
    }
    
    func summary () {
        var summary = "Your current progress"
        var sayThisSummary = AVSpeechUtterance(string: summary)
        voice.speak(sayThisSummary)
    
    }
    
    
}
