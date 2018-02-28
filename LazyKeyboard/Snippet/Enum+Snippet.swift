//
//  Enum+Snippet.swift
//  Snippet
//
//  Created by sunny on 2017/11/12.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import Foundation

// 对于是 Int 类型的枚举来说，这两个 api 分别返回枚举值的总数，以及一个包含所有枚举值的数组
extension RawRepresentable where RawValue == Int {
    
    static var itemCount: Int {
        var index = 0
        while Self(rawValue: index) != nil { index += 1 }
        return index
    }
    
    static var items:[Self] {
        var items: [Self] = []
        var index = 0
        while let item = Self(rawValue: index) {
            items.append(item)
            index += 1
        }
        return items
    }
}
