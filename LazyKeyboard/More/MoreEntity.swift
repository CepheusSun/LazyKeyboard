//
//  MoreEntity.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/2/28.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import Foundation

struct MoreSection {
    var header: String?
    var footer: String?
    
    var items: [MoreItem] = []
    
//    init(header: String?, footer: String?, items: [MoreItem]) {
//        self.header = header
//        self.footer = footer
//        self.items = items
//    }
    
}

struct MoreItem {
    var title: String = ""
    var showMore: Bool?
    var message: String?
    var switchState: Bool?
    var action: (() -> ())
    
//    init(title: String, showMore: Bool?, message: String?, switchState: Bool?, action: @escaping (() -> ())) {
//        self.title = title
//        self.showMore = showMore
//        self.message = message
//        self.switchState = switchState
//        self.action = action
//    }
//
    mutating func toggle(_ isOn: Bool) {
        if self.switchState.hasSome {
            self.switchState = isOn
        }
    }
}
