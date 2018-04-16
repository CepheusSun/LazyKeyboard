//
//  RealmTool.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/4/16.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

final class RealmManager<T: Object> {
    
    typealias Model = T
    
    // 增加， 插入一条
    func insert(_ s: T) {
        try! self.realm.write {
            self.realm.add(s)
        }
    }
    
    // 删除， 删除一条
    func delete(_ s: T) {
        try! realm.write {
            self.realm.delete(s)
        }
    }
    
    // 查询， 查询
    func select() -> Results<T> {
        let res = realm.objects(Model.self)
        return res
    }
    
//     修改，将修改后的模型传入
//    func update(_ s: T) {
//        try! realm.write {
//            self.realm.add(s, update: true)
//        }
//    }
    
    var realm: Realm!
    
    func configRealm() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let filePath = paths[0] + "/\(Model.self).realm"
        var realmConfiguration = Realm.Configuration()
        realmConfiguration.fileURL = URL(string: filePath)!
        // 数据库版本号
        let currentVersion: UInt64 = 1;
        realmConfiguration.schemaVersion = currentVersion;
        realmConfiguration.migrationBlock = {
            if  currentVersion > $1 {
                // 数据库迁移相关的东西
            }
        }
        
        realm = try! Realm.init(configuration: realmConfiguration)
    }
    
    init() {
        self.configRealm()
    }
}


