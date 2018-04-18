//
//  HomeViewModel.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/4/18.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import Realm

final class HomeViewModel {
    
    var output = PublishSubject<Bool>()
    
    var db = RealmManager<TypeObject>()
    var dbType: Results<TypeObject>!

    var syllableDB = RealmManager<Syllable>()

    var list: [String] = []
    init() {
        dbType = db.select()
        if dbType.isEmpty {
            let typeObj = TypeObject()
            typeObj.content = "默认"
            db.insert(typeObj)
            dbType = db.select()
        }
        list = dbType[0].content.components(separatedBy: "&&&")
    }
    
    func updateDB() {
        let content = list.joined(separator: "&&&")
        db.realm.beginWrite()
        dbType[0].content = content
        try! db.realm.commitWrite()
        self.output.onNext(true)
    }
    
    func edit(_ s: String, at index: Int) {
        list[index] = s
        updateDB()
        // 修改所有字段
        syllableDB.select().filter("type = '\(list[index])'").forEach({
            syllableDB.realm.beginWrite()
            $0.type = s
            try! syllableDB.realm.commitWrite()
        })
        self.output.onNext(true)
    }
    
    func add(_ s: String) {
        list.append(s)
        updateDB()
    }
    
    func delete(_ s: IndexPath) {
        // 删除字段
        syllableDB.select().filter("type = '\(list[s.row])'").forEach{syllableDB.delete($0)}
        list.remove(at: s.row)
        self.output.onNext(true)
        updateDB()
    }
    
    func move(_ from: IndexPath, to: IndexPath) {
        let s = list[from.row]
        list.remove(at: from.row)
        list.insert(s, at: to.row)
        updateDB()
    }
}
