//
//  KeyboardViewModel.swift
//  Lazy
//
//  Created by sunny on 2018/3/1.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import Foundation


final class KeyboardViewModel {
    
    lazy var list: [String] = {
        let list = C.groupUserDefaults?.object(forKey: C.syllableKey) as? [String]
        return list.or([])!
    }()
    
    lazy var pageCount: Int = {
        if list.count == 0 {
            return 0
        }
        return list.count / 8 + 1
    }()
    
    lazy var pages: [[Key]] = {

        var res: [[Key]] = []
        (0..<pageCount).forEach({ _ in
            res.append([])
        })
        
        for (index, item) in list.enumerated() {
            let i = index / 8
            let j = index % 8
            let key = Key(Key.KeyType.character(item))
            res[i].append(key)
        }
        return res.map({$0.flatMap({$0})})
    }()
}


