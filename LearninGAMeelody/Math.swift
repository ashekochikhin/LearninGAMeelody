//
//  Math.swift
//  LearninGAMeelody
//
//  Created by Алексей Щекочихин on 24/11/2017.
//  Copyright © 2017 Ashe Inc. All rights reserved.
//

import Foundation

func randomNumber(probabilities: [Double]) -> Int {
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
