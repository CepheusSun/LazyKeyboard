//
//  SyllableSection.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/3/27.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import Foundation
import IceCream
import Realm
import RealmSwift

final class SyllableSection: Object, Codable {
    
    @objc dynamic var list: [String] = []
    @objc dynamic var title: String = "默认"
    @objc dynamic var isDeleted = false
    // 一下全部都要再加一个维度
    lazy var pageCount: Int = {
        if list.count == 0 {
            return 0
        } else {
            return list.count / 8 + 1
        }
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

extension SyllableSection: CKRecordConvertible {}
extension SyllableSection: CKRecordRecoverable {}
