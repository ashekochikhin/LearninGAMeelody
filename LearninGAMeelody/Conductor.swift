//
//  Conductor.swift
//  LearninGAMeelody
//
//  Created by Алексей Щекочихин on 25/11/2017.
//  Copyright © 2017 Ashe Inc. All rights reserved.
//

import Foundation
import AudioKit

let conductor = Conductor()

class Conductor {
    private var sequencer: AKSequencer!
//    private var osc = AKOscillatorBank()
    private var grandPiano = AKMIDISampler()
    
    init() {

        AudioKit.output = grandPiano
//        let midi = AKMIDINode(node: osc)
//        midi.enableMIDI()
        grandPiano.enableMIDI()
        
        do {
            try grandPiano.loadEXS24("Grand Piano")
        } catch {
            print("A file was not found.")
        }
        
        
        AudioKit.start()
        sequencer = AKSequencer()
//        sequencer.setTempo(Double(220.0))
        sequencer.setLength(AKDuration(beats: Double(melodyLengthIn16/16)))
        _=sequencer.newTrack()
        sequencer.tracks[0].setMIDIOutput(grandPiano.midiIn)
        
    }
    
    
    func playSequence() {
        sequencer.play()
    }
    
    func stopSequence() {
        sequencer.stop()
    }
    
    func rewindSequence() {
        sequencer.rewind()
    }
    
    func setLength(_ length: Double) {
        AKLog("Setting Length \(length)")
        sequencer.setLength(AKDuration(beats: 16))
        for track in sequencer.tracks {
            track.resetToInit()
        }
        sequencer.setLength(AKDuration(beats: length))
        sequencer.setLoopInfo(AKDuration(beats: length), numberOfLoops: 0)
        sequencer.rewind()
    }
    
    func adjustTempo(_ tempo: Float) {
        sequencer?.setRate(Double(tempo))
    }
    
    func playMelody(melody: Notes) -> Void {
        sequencer.stop()
        sequencer.rewind()
        sequencer.tracks[0].clear()
        let notes = melody.notes
        var position = Double(0)
        
        for i in 0..<notes.count {

            let duration = Double(notes[i][1])/4
 
            sequencer.tracks[0].add(noteNumber: MIDINoteNumber(notes[i][2] + 60), velocity: MIDIVelocity(notes[i][0]*100), position: AKDuration(beats: position), duration: AKDuration(beats: duration))
            position = position + duration

        }

        sequencer.play()

    
    }

}
