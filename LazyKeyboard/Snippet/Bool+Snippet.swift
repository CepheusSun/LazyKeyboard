//
//  Bool+Snippet.swift
//  More
//
//  Created by sunny on 2017/11/16.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import Foundation

extension Bool {
    
    /// Returns a random boolean value.
    ///
    ///     Bool.random -> true
    ///     Bool.random -> false
    ///
    static var random: Bool {
        return arc4random_uniform(2) == 1
    }
    
    func int() -> Int {
        return self ? 1 : 0
    }
    
    func string() -> String {
        return description
    }
    
}
