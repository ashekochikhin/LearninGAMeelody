//
//  Melody.swift
//  LearninGAMeelody
//
//  Created by Алексей Щекочихин on 10/01/2017.
//  Copyright © 2017 Ashe Inc. All rights reserved.
//

import Foundation
import AudioKit

let melodyLengthIn16=128

class Notes{
    var notes = [[Int()]]
}

private func randomNumber(probabilities: [Double]) -> Int {
    let sum = probabilities.reduce(0, +)
    let rnd = sum * Double(arc4random_uniform(UInt32.max)) / Double(UInt32.max)
    var accum = 0.0
    for (i, p) in probabilities.enumerated() {
        accum += p
        if rnd < accum {
            return i
        }
    }
    return (probabilities.count - 1)
}

func makeMelodyInNotesOfRules(_melody: Int, _mode: Int, _rhythm: Int) -> Notes{
    let notes = Notes()
    
    
    struct rhythmItem {
        var type = Int()
        var length = Int()
    }
    
    var rhythm = [rhythmItem()]
    
    var sumL = 0
    while (sumL<melodyLengthIn16) {
        let l1uQ = (Int(arc4random_uniform(UInt32(16)))+1)
        let l1 = l1uQ - (l1uQ % rhythmRulesSet[_rhythm])
        
        if(sumL+l1<melodyLengthIn16){rhythm.append(rhythmItem.init(type: randomNumber(probabilities: [0.3, 0.7]), length: l1))} else { rhythm.append(rhythmItem.init(type: randomNumber(probabilities: [0.3, 0.7]), length: melodyLengthIn16-sumL))}
        sumL += l1
    }
    print(rhythm)
    let numberOfItems = rhythm.count
    
    let modeRules=modeRulesSet[_mode]
    print (modeRules)
    
    let melodyRules=melodyRulesSet[_melody]
    print(melodyRules)
    
    var nextnote = 0
    var currentnote = 1
    notes.notes[0]=[0, 0, 1]
    for i in 0...(numberOfItems-1) {
        if (rhythm[i].type == 1) {
            notes.notes.append([1, rhythm[i].length, modeRules[((Int(arc4random_uniform(2))*2-1)*nextnote+currentnote+144)%7] ])
            //notes[i][0]=1
            //notes[i][1]=self.rythm[i].length
            //notes[i][2]+=nextnote
            currentnote+=nextnote
            nextnote=randomNumber(probabilities: melodyRules)
        } else {
            notes.notes.append([0, rhythm[i].length, 0 ])
            //notes[i][0]=0
            //notes[i][1]=self.rythm[i].length
            //notes[i][2]=0
        }
    }
    notes.notes.remove(at: 0)
    notes.notes.remove(at: 0)
    print(notes.notes)
    return notes
}

func playMelody(melody: Notes)->Void{
    let notes = melody.notes
    AudioKit.stop()
    
    var midi = AKMIDI()
    var fmOscillator = AKFMOscillatorBank()
    var melodicSound: AKMIDINode?
    var verb: AKReverb2?
    
    var sequence = AKSequencer()
    var mixer = AKMixer()
    var pumper: AKCompressor?
    
    let currentTempo = 400.0
    let sequenceLength = AKDuration(beats: Double(melodyLengthIn16/4), tempo: currentTempo)
    

    
    
    fmOscillator.modulatingMultiplier = 3
    fmOscillator.modulationIndex = 0.3
    
    melodicSound = AKMIDINode(node: fmOscillator)
    melodicSound?.enableMIDI(midi.client, name: "melodicSound midi in")
    verb = AKReverb2(melodicSound!)
    verb?.dryWetMix = 0.5
    verb?.decayTimeAt0Hz = 3
    verb?.decayTimeAtNyquist = 7
    verb?.randomizeReflections = 600
    verb?.gain = 1
    
    pumper = AKCompressor(mixer)
    
    pumper?.headRoom = 0.10
    pumper?.threshold = -15
    pumper?.masterGain = 10
    pumper?.attackTime = 0.01
    pumper?.releaseTime = 0.3
    
    mixer.connect(verb!)
    AudioKit.output = pumper
    AudioKit.start()
    
    sequence.newTrack()
    sequence.tracks[0].setMIDIOutput(melodicSound!.midiIn)
//    sequence.setLength(sequenceLength)
//    sequence.setTempo(currentTempo)
//    
    var position = Double(0)
    for i in 0..<notes.count{
        var duration = Double(notes[i][1]/4)
        
        sequence.tracks[0].add(noteNumber: notes[i][2]+60, velocity: notes[i][0]*100, position: AKDuration(beats: position,tempo: currentTempo), duration: AKDuration(beats: duration, tempo: currentTempo))
        position = position + duration
        
    }
    
    print (sequence.length, sequence.tempo)
    sequence.play()
}


