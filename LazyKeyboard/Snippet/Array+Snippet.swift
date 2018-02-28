//
//  Array+Snippet.swift
//  Snippet
//
//  Created by sunny on 2017/11/12.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import Foundation

extension Array where Element: Numeric {
    
    /// Sum of all elements in Array
    ///
    ///    [1, 2, 3, 4, 5].sum() -> 15
    ///
    /// - Returns: sum of the array element
    func sum() -> Element {
        return reduce(0, +)
    }
}

extension Array where Element: FloatingPoint {
    
    /// Average of all elements in Array
    ///
    /// - Returns: average of the array element
    func average() -> Element? {
        guard !isEmpty else { return nil }
        let sum = reduce(0, +)
        return sum / Element(count)
    }
}

extension Array {
    
    // it removes the first element that matches the handler condition on the array it self
    @discardableResult public mutating func remove(_ handler: (Element) -> Bool) -> Element? {
        guard let idx = index(where: handler) else { return nil }
        let item = self[idx]
        remove(at: idx)
        return item
    }
    
    // it removes the first element that matches the handler condition & return a new array
    public func removed(_ handler:(Element) -> Bool) -> Array {
        var items = self
        items.remove(handler)
        return items
    }
    
    
    /// item of the given index if exists
    ///
    /// - Parameter index: index of element
    /// - Returns: optional element (if exists).
    func item(at index: Int) -> Element? {
        guard startIndex..<endIndex ~= index else { return nil }
        return self[index]
    }    
}
