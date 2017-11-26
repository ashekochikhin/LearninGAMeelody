//
//  MelodyRules.swift
//  LearninGAMeelody
//
//  Created by Алексей Щекочихин on 04/01/2017.
//  Copyright © 2017 Ashe Inc. All rights reserved.
//

import Foundation
// Rhythmic rules. Integer sets the longest note length
//let rhythmRulesSet = [16, 8, 4, 2, 1]
let rhythmRulesSet = [8, 4, 3 , 2, 1]

// Mode rules. Each set represnt allowed note numbers corresponding to each mode
//let modeRulesSet = [[1, 3, 5, 6, 8, 10, 12], [1, 3, 5, 6, 8, 9, 12], [1, 3, 5, 6, 8, 9, 11], [1, 3, 4, 6, 8, 10, 12], [1, 3, 4, 6, 8, 9, 12], [1, 3, 4, 6, 8, 9, 11]]
let modeRulesSet = [[1, 4, 8, 13] ,  [1, 5, 8, 13]]

// Melodic rules. Probobility of moving from one note to anothr
let melodyRulesSet = [[0.60, 0.30, 0.10, 0.00],[0.30, 0.30, 0.30, 0.10], [0.20, 0.30, 0.30, 0.20], [ 0.10, 0.30, 0.30, 0.30],[0.00, 0.10, 0.30, 0.60]]

// Class represents a set of all rules
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
        rhythm = Int16(arc4random_uniform(UInt32(rhythmRulesSet.count)))
        mode = Int16(arc4random_uniform(UInt32(modeRulesSet.count)))
        melody = Int16(arc4random_uniform(UInt32(melodyRulesSet.count)))
    }

    func setRandomMelodyRules(){
        self.rhythm = Int16(arc4random_uniform(UInt32(rhythmRulesSet.count)))
        self.mode = Int16(arc4random_uniform(UInt32(modeRulesSet.count)))
        self.melody = Int16(arc4random_uniform(UInt32(melodyRulesSet.count)))
    }

    
}

//Current Melody Rules to sonificate
var currentMelodyRules = MelodyRules()
