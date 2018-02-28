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
    
}

struct MoreItem {
    var title: String = ""
    var showMore: Bool?
    var message: String?
    var switchState: Bool?
    var action: () -> ()
}
