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
    
    var realm: Realm!
    
    func configRealm() {
        
        let path = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: C.groupAppIdentifier)
        let fileURL = path!.appendingPathComponent("\(Model.self).realm")

        var realmConfiguration = Realm.Configuration()
        
        realmConfiguration.fileURL = fileURL
        // 数据库版本号
        let currentVersion: UInt64 = 1;
        realmConfiguration.schemaVersion = currentVersion;
        realmConfiguration.migrationBlock = {
            if  currentVersion > $1 {
                // 数据库迁移相关的东西
            }
        }
        
        print(fileURL)
        Realm.Configuration.defaultConfiguration = realmConfiguration
        do {
            realm = try Realm()
        } catch {
            fatalError("错了错了错了❌❌\(fileURL)。。。xxxxxxx。。。\(error)")
        }
        
    }
    
    init() {
        self.configRealm()
    }
}


