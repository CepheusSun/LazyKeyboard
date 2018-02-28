//
//  Regex.swift
//  Snippet
//
//  Created by sunny on 2017/9/15.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import Foundation

fileprivate struct Regex {
    let regex: NSRegularExpression?
    
    init(_ pattern: String) {
        regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    func match(input: String) -> Bool {
        if let matches = regex?.matches(in: input, options: [], range: NSMakeRange(0, input.count)) {
            return matches.count > 0
        }
        else {
            return false
        }
    }
}

extension String {
    enum RegexPattern: String{
        case phoneNumber = "^[1][35678][0-9]{9}$"
        case phoneCode = "^[0-9]{6}$"
        case password = "^(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[a-zA-Z])(?=.*[\\!\\@\\#\\$\\^\\&\\*\\-\\_])|(?=.*\\d)(?=.*[\\!\\@\\#\\$\\^\\&\\*\\-\\_])[a-zA-Z\\d\\!\\@\\#\\$\\^\\&\\*\\-\\_]+$"
        case email = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
    }
    
    func mathch(_ pattern: RegexPattern) -> Bool {
        let match = Regex(pattern.rawValue)
        return match.match(input: self)
    }
}


