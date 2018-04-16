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
}


