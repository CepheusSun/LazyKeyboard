//
//  URL+Snippet.swift
//  Snippet
//
//  Created by sunny on 2017/11/27.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import Foundation


extension URL: ExpressibleByStringLiteral {
    
    // By using 'StaticString' we disable string interpolation, for safety
    public init(stringLiteral value: StaticString) {
        self = URL(string: "\(value)").require(hint: "Invalid URL string literal: \(value)")
    }
}

// let url: URL = "https://www.baidu.com"
// let task = URLSession.shared.dataTask(with: url)
// let task2 = URLSession.shared.dataTask(with: "https://www.baidu.com")


