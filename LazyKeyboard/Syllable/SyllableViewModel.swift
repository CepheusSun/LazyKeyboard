//
//  HomeViewModel.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/2/28.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import Realm

final class SyllableViewModel {
    
    var output = PublishSubject<Bool>()
    
    var db = RealmManager<Syllable>()
    var list: Results<Syllable>!
    
    init(with type: String) {
        let res = C.groupUserDefaults?.object(forKey: C.syllableKey) as? [String]
        if let r = res {
            for (index, item) in r.enumerated() {
                let syllable: Syllable = Syllable()
                syllable.type = "默认"
                syllable.content = item
                syllable.rank = index
                db.insert(syllable)
            }
            C.groupUserDefaults?.removeObject(forKey: C.syllableKey)
        }
        list = db.select().filter("type = '\(type)'").sorted(byKeyPath: "rank")
    }
    
    func addSyllable(_ s: String, type: String) {

        let syllable = Syllable()
        syllable.type = type
        syllable.content = s
        syllable.rank = list.count
        db.insert(syllable)
        self.output.onNext(true)
    }
    
    func delete(_ s: IndexPath) {
        db.delete(list[s.row])
        db.realm.beginWrite()
        list.filter({$0.rank > s.row}).forEach({$0.rank -= 1})
        try! db.realm.commitWrite()
        self.output.onNext(true)
    }
    
    func move(_ from: IndexPath, to: IndexPath) {
        db.realm.beginWrite()
        // 往上排序
        if from.row > to.row { //
            let temp = list[from.row]
            list.filter{$0.rank >= to.row && $0.rank < from.row}.forEach{$0.rank += 1}
            temp.rank = to.row
        } else {
            let temp = list[from.row]
            list.filter{$0.rank > from.row && $0.rank <= to.row}.forEach{$0.rank -= 1}
            temp.rank = to.row
        }
        try! db.realm.commitWrite()
        self.output.onNext(true)
    }
    
    func editSyllable(_ s: String, at index: Int) {
        let syllable = list[index]
        db.realm.beginWrite()
        syllable.content = s
        try! db.realm.commitWrite()
        self.output.onNext(true)
    }
    
    func editSyllableAlias(_ s: String?, at index: Int) {
        var res = s
        if s == "" {
            res = nil
        }
        let syllable = list[index]
        db.realm.beginWrite()
        syllable.alias = res
        try! db.realm.commitWrite()
        self.output.onNext(true)
    }

    // 分组相关
    func changeSyllableType(from: String, to: String, at index: Int) {
        // 修改分组, 走到这里代表这个分组之前一定是已经存在了的
        db.realm.beginWrite()
        // 修改
        let temp = list[index]
        temp.type = to
        temp.rank = db.select().filter("type = '\(to)'").count
        // 当前的往上移动1个
        list.filter{$0.rank >= index}.forEach{$0.rank -= 1}
        try! db.realm.commitWrite()
        self.output.onNext(true)
    }
    
}
