//
//  Melody.swift
//  LearninGAMeelody
//
//  Created by Алексей Щекочихин on 10/01/2017.
//  Copyright © 2017 Ashe Inc. All rights reserved.
//

import Foundation
import AudioKit

//Length of generated melodies in 16th notes
let melodyLengthIn16=64

struct Notes{
    var notes = [[Int()]]
}

struct rhythmItem {
    var type = Int()
    var length = Int()
}

func makeMelodyInNotesOfRules(_melody: Int, _mode: Int, _rhythm: Int) -> Notes{
    //Creating emty notes
    var notes = Notes()
    //Creating emty rhysmic item
    var rhythm = [rhythmItem()]
    //Init sum length
    var sumL = 0
    
    //looping untill sum length is less then melody length
    while (sumL<melodyLengthIn16) {
        // Generating random note length with max length of current rhythmic rule
        let l1 = (Int(arc4random_uniform(UInt32(rhythmRulesSet[_rhythm])))+1)

        if (sumL+l1<melodyLengthIn16) {
                rhythm.append(rhythmItem.init(type: randomNumber(probabilities: [0, 1]), length: l1))
            } else {
                rhythm.append(rhythmItem.init(type: randomNumber(probabilities: [0, 1]), length: melodyLengthIn16-sumL))
            }
        sumL += l1
    }
    let numberOfItems = rhythm.count
    
    let modeRules=modeRulesSet[_mode]
    
    let melodyRules=melodyRulesSet[_melody]
    
    var nextnote = 0
    var currentnote = 1
    notes.notes[0]=[0, 0, 1]
    for i in 0...(numberOfItems-1) {
        if (rhythm[i].type == 1) {
            let modeRuleNumber = ((Int(arc4random_uniform(2))*2-1)*nextnote+currentnote+144)%4
            let newNote = [1, rhythm[i].length, modeRules[modeRuleNumber]]
            notes.notes.append(newNote)
            currentnote+=nextnote
            nextnote=randomNumber(probabilities: melodyRules)
        } else {
            notes.notes.append([0, rhythm[i].length, 0 ])
        }
    }
    notes.notes.remove(at: 0)
    notes.notes.remove(at: 0)
    
    return notes
}




