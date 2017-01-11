//
//  LangugeDescription.swift
//  LearninGAMeelody
//
//  Created by Алексей Щекочихин on 07/01/2017.
//  Copyright © 2017 Ashe Inc. All rights reserved.
//

import Foundation

class UserLanguageDescription{
    var rhythmDescription: String
    var modeDescription: String
    var melodyDescription: String
    
    init(_rhythm: String, _mode: String, _melody: String){
        rhythmDescription = _rhythm
        modeDescription = _mode
        melodyDescription = _melody
    }
}

