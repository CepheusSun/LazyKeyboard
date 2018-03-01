//
//  KeyboardEntity.swift
//  Lazy
//
//  Created by sunny on 2018/3/1.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import Foundation

class Key {
    enum KeyType {
        case character
        case backspace
        case space
        case keyboardChange
        case `return`
    }
    
    var type: KeyType
    var letter: String?
    
    init(_ type: KeyType) {
        self.type = type
    }
    
    var isCharacter: Bool {
        get {
            return type == .character
        }
    }

    var isSpecial: Bool {
        get {
            return type != .character
        }
    }
    
    func setLetter(_ letter: String) {
        self.letter = letter
    }
}


