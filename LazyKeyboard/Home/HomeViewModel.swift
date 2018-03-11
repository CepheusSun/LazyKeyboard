//
//  HomeViewModel.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/2/28.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import Foundation
import RxSwift

final class HomeViewModel {
    
    var output = PublishSubject<Bool>()

    var list: [SyllableSection] = {
        
        let origin = C.groupUserDefaults?.object(forKey: C.syllableKey) as? [String]
        if origin.hasSome {
            // 数据转移
            var section = SyllableSection()
            section.list = origin!
            section.title = "默认"
            return [section]
        } else {
            let defaults = Defaults(userDefaults: C.groupUserDefaults!)
            let key = Key<[SyllableSection]>(C.syllableKey)
            let list = defaults.get(for: key)
            return list.or([])!
        }
    }()
    
    func addSyllable(_ s: String) {
        // FIXME:
        list[0].list.append(s)
        C.groupUserDefaults?.set(list, forKey: C.syllableKey)
        C.groupUserDefaults?.synchronize()
        self.output.onNext(true)
    }
    
    func delete(_ s: [IndexPath]) {
        s.forEach { (indexPath) in
            list.remove(at: indexPath.row)
        }
        C.groupUserDefaults?.set(list, forKey: C.syllableKey)
        C.groupUserDefaults?.synchronize()
    }
    
    func move(_ from: IndexPath, to: IndexPath) {
        let obj = list[from.row]
        list.remove(at: from.row)
        list.insert(obj, at: to.row)
        C.groupUserDefaults?.set(list, forKey: C.syllableKey)
        C.groupUserDefaults?.synchronize()
    }
    
    func editSyllable(_ s: String, at index: Int) {
        list[0].list[index] = s
        C.groupUserDefaults?.set(list, forKey: C.syllableKey)
        C.groupUserDefaults?.synchronize()
        self.output.onNext(true)
    }
    
}
