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
}
