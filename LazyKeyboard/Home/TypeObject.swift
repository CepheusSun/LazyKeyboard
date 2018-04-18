//
//  TypeObject.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/4/18.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import Foundation
import IceCream
import Realm
import RealmSwift

final class TypeObject: Object, Codable {
    
    @objc dynamic var content: String = ""
    @objc dynamic var isDeleted = false
    
}

extension TypeObject: CKRecordConvertible {}
extension TypeObject: CKRecordRecoverable {}
