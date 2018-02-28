//
//  Generic+Snippet.swift
//  Snippet
//
//  Created by sunny on 2017/11/12.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import Foundation

// 这里定义一些常用的 Closure
typealias Closure<T, P> = (T) -> (P)

typealias TakeClosure<T> = (T) -> Void

typealias ReturnClosure<T> = () -> T

typealias EmptyClosure = () -> Void

