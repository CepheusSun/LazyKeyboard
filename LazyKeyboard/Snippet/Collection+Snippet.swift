//
//  Collection+Snippet.swift
//  Snippet
//
//  Created by sunny on 2017/11/12.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import Foundation

// 用来获取集合类型数据中，某个元素前一个或者后一个
public extension Collection where Iterator.Element: Equatable {
    
    public func after(_ element: Iterator.Element) -> Iterator.Element? {
        guard let idx = index(of: element), index(after: idx) < endIndex else { return nil }
        let nextIdx = index(after: idx)
        return self[nextIdx]
    }
    
    public func before(_ element: Iterator.Element) -> Iterator.Element? {
        guard let idx = index(of: element), index(before: idx) >= startIndex else { return nil }
        let previousIdx = index(idx, offsetBy: -1)
        return self[previousIdx]
    }
    
    public func index(before idx: Index) -> Index {
        return index(idx, offsetBy: -1)
    }
    
}

