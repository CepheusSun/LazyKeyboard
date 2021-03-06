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

    var typeDB = RealmManager<TypeObject>()
    var typelist: [String] = []

    init() {
        let res = C.groupUserDefaults?.object(forKey: C.syllableKey) as? [String]
        if let r = res {
            for (index, item) in r.enumerated() {
                let syllable: Syllable = Syllable()
                syllable.type = "默认"
                syllable.content = item
                syllable.rank = index
                db.insert(syllable)
            }
            C.groupUserDefaults?.removeObject(forKey: C.syllableKey)
        }
        let temp = db.select().sorted(byKeyPath: "rank")
        for x in temp.enumerated() {
            list.append(x.element)
        }
        
        var typeObject = typeDB.select()
        if typeObject.isEmpty {
            let typeObj = TypeObject()
            typeObj.content = "默认"
            typeDB.insert(typeObj)
            typeObject = typeDB.select()
        }
        typelist = typeObject[0].content.components(separatedBy: "&&&")
    }
    
    func refresh(type: String) {
        let temp = db.select().filter("type = '\(type)'").sorted(byKeyPath: "rank")
        list = []
        for x in temp.enumerated() {
            list.append(x.element)
        }
        pageCount = getPageCount()
        pages = getPages()
    }
    
    var pageCount: Int = 0

    private func getPageCount() -> Int {
        if list.count == 0 {
            return 0
        }
        return list.count / 8 + 1
    }
    
    lazy var pages: [[KeyButton]] = []
    
    private func getPages() -> [[KeyButton]] {
        var res: [[KeyButton]] = []
        (0..<pageCount).forEach({ _ in
            res.append([])
        })
        
        for (index, item) in list.enumerated() {
            let i = index / 8
//            let j = index % 8
            let key = KeyButton(KeyButton.KeyType.character(item))
            res[i].append(key)
        }
        return res.map({$0.compactMap({$0})})
    }
    
}


