//
//  RxExtensions.swift
//
//  Created by sunny on 2017/5/8.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

infix operator <->

infix operator <~

infix operator ~>

// Two way binding operator between control property and variable, that's all it take
func <-> <T>(property: ControlProperty<T> , variable: Variable<T>) -> Disposable {
    let bindToUIDisposable = variable.asObservable()
    .bind(to: property)
    let bindToVariable = property
        .subscribe(onNext: {[unowned variable] (n) in
            variable.value = n
        }, onCompleted: {
            bindToUIDisposable.dispose()
        })
    return Disposables.create(bindToUIDisposable, bindToVariable)
}

// One way binding operator
func <~ <T>(property: Variable<T>, variable: Variable<T>) -> Disposable {
    return variable.asObservable().bind(to: property)
}

func ~> <T>(variable: Variable<T>, property:Variable<T>) -> Disposable {
    return variable.asObservable().bind(to: property)
}



//
func + <T, U>(lhs: [T: U], rhs: [T: U]) -> [T: U] {
    var lhsCopy = lhs
    for (key, val) in rhs {
        lhsCopy[key] = val
    }
    
    return lhsCopy
}


