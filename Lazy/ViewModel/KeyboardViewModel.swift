//
//  KeyboardViewModel.swift
//  Lazy
//
//  Created by sunny on 2018/3/1.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import Foundation


final class KeyboardViewModel {
    
    let setting = App.getSettingConfig()
    
    lazy var list: [SyllableSection] = {
        
        let origin = C.groupUserDefaults?.object(forKey: C.syllableKey) as? [String]
        if origin.hasSome {
            // 数据转移
            var section = SyllableSection()
            section.list = origin!
            section.title = "默认"
            return [section]
        } else {
            let defaults = Defaults(userDefaults: C.groupUserDefaults!)
            let key = Key<[SyllableSection]>(C.syllableKey)
            let list = defaults.get(for: key)
            return list.or([])!
        }
    }()
}


