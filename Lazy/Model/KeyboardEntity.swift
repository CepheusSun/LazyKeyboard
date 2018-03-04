//
//  KeyboardEntity.swift
//  Lazy
//
//  Created by sunny on 2018/3/1.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import Foundation

class KeyButton {
    enum KeyType {
        case character(String)
        case backspace
        case space
        case spaceLongPress
        case keyboardChange
        case `return`
        case at
    }
    
    var type: KeyType
    
    init(_ type: KeyType) {
        self.type = type
    }
    
}


