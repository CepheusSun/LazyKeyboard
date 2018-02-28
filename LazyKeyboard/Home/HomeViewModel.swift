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
        var list = C.groupUserDefaults?.object(forKey: "syllable") as? [String]
        return list.or([])!
    }()
    
    func addSyllable(_ s: String) {
        list.append(s)
        C.groupUserDefaults?.set(list, forKey: "syllable")
        self.output.onNext(true)
    }
    
    func delete(_ s: [String]) {
        
    }
    
    func change(_ s: String) {
        
    }
    
}
