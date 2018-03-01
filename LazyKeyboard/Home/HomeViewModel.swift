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

    var list: [String] = {
        var list = C.groupUserDefaults?.object(forKey: C.syllableKey) as? [String]
        return list.or([])!
    }()
    
    func addSyllable(_ s: String) {
        list.append(s)
        C.groupUserDefaults?.set(list, forKey: C.syllableKey)
        self.output.onNext(true)
    }
    
    func delete(_ s: [IndexPath]) {
        s.forEach { (indexPath) in
            list.remove(at: indexPath.row)
        }
        C.groupUserDefaults?.set(list, forKey: C.syllableKey)
    }
    
    func move(_ from: IndexPath, to: IndexPath) {
        let obj = list[from.row]
        list.remove(at: from.row)
        list.insert(obj, at: to.row)
        C.groupUserDefaults?.set(list, forKey: C.syllableKey)
    }
    
    func editSyllable(_ s: String, at index: Int) {
        list[index] = s
        C.groupUserDefaults?.set(list, forKey: C.syllableKey)
        self.output.onNext(true)
    }
    
}
