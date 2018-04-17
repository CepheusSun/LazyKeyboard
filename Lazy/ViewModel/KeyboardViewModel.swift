//
//  KeyboardViewModel.swift
//  Lazy
//
//  Created by sunny on 2018/3/1.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class KeyboardViewModel {
    
    let setting = App.getSettingConfig()
    var db = RealmManager<Syllable>()
    var list: [Syllable] = []
    
    init() {
        let temp = db.select().sorted(byKeyPath: "rank")
        for x in temp.enumerated() {
            list.append(x.element)
        }
        print(list)
    }
    
    lazy var pageCount: Int = {
        if list.count == 0 {
            return 0
        }
        return list.count / 8 + 1
    }()
    
    lazy var pages: [[KeyButton]] = {
        
        var res: [[KeyButton]] = []
        (0..<pageCount).forEach({ _ in
            res.append([])
        })
        
        for (index, item) in list.enumerated() {
            let i = index / 8
            let j = index % 8
            let key = KeyButton(KeyButton.KeyType.character(item))
            res[i].append(key)
        }
        return res.map({$0.compactMap({$0})})
    }()
    
}


