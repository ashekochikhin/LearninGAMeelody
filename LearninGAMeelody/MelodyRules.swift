//
//  MelodyRules.swift
//  LearninGAMeelody
//
//  Created by Алексей Щекочихин on 04/01/2017.
//  Copyright © 2017 Ashe Inc. All rights reserved.
//

import Foundation

let rhythmRulesSet = [16, 8, 4, 2, 1] // ala quantize
let modeRulesSet = [[1, 3, 5, 6, 8, 10, 12], [1, 3, 5, 6, 8, 9, 12], [1, 3, 5, 6, 8, 9, 11], [1, 3, 4, 6, 8, 10, 12], [1, 3, 4, 6, 8, 9, 12], [1, 3, 4, 6, 8, 9, 11]] 
let melodyRulesSet = [[0.60, 0.30, 0.10, 0.00, 0.00, 0.00, 0.00, 0.00],[0.30, 0.30, 0.30, 0.10, 0.00, 0.00, 0.00, 0.00], [0.10, 0.10, 0.20, 0.20, 0.20, 0.10, 0.10], [0.00, 0.00, 0.00, 0.10, 0.30, 0.30, 0.30],[0.00, 0.00, 0.00, 0.00, 0.10, 0.30, 0.60]]

class MelodyRules {
    var rhythm: Int16
    var mode: Int16
    var melody: Int16
    
    init(_rhythm: Int16, _mode: Int16, _melody: Int16) {
        rhythm = _rhythm
        mode = _mode
        melody = _melody
    }
    
    init() {
        rhythm = Int16(arc4random_uniform(UInt32(rhythmRulesSet.count)-1))
        mode = Int16(arc4random_uniform(UInt32(modeRulesSet.count)-1))
        melody = Int16(arc4random_uniform(UInt32(melodyRulesSet.count)-1))
    }

    func setRandomMelodyRules(){
        self.rhythm = Int16(arc4random_uniform(UInt32(rhythmRulesSet.count)-1))
        self.mode = Int16(arc4random_uniform(UInt32(modeRulesSet.count)-1))
        self.melody = Int16(arc4random_uniform(UInt32(melodyRulesSet.count)-1))
    }

    
}

var currentMelodyRules = MelodyRules()
