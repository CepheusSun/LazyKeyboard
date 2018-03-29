//
//  Syllable.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/3/11.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import Foundation
import IceCream
import Realm
import RealmSwift

final class Syllable: Object, Codable {
    
    @objc dynamic var content: String?
    @objc dynamic var type: String?
    @objc dynamic var alias: String?
    @objc dynamic var rank: Int = 0
    @objc dynamic var isDeleted = false
    
}

extension Syllable: CKRecordConvertible {}
extension Syllable: CKRecordRecoverable {}



