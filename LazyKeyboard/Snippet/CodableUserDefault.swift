//
//  CodableUserDefault.swift
//  More
//
//  Created by sunny on 2018/1/19.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import Foundation


final class Key<ValueType: Codable> {
    fileprivate let _key: String
    init(_ key: String) {
        _key = key
    }
}


final class Defaults {
    
    private var userDefaults: UserDefaults
    
    static let shared = Defaults()
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func clear<ValueType>(_ key: Key<ValueType>) {
        userDefaults.set(nil, forKey: key._key)
        userDefaults.synchronize()
    }
    
    func has<ValueType>(_ key: Key<ValueType>) -> Bool {
        return userDefaults.value(forKey: key._key) != nil
    }
    
    
    func get<ValueType>(for key: Key<ValueType>) -> ValueType? {
        if isSwiftCodableType(ValueType.self) || isFoundationCodableType(ValueType.self) {
            return userDefaults.value(forKey: key._key) as? ValueType
        }
        
        guard let data = userDefaults.data(forKey: key._key)  else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(ValueType.self, from: data)
            return decoded
        } catch {
            #if DEBUG
            print(error)
            #endif
        }
        return nil
    }
    
    func set<ValueType>(_ value: ValueType, for key:Key<ValueType>) {
        if isSwiftCodableType(ValueType.self) || isFoundationCodableType(ValueType.self) {
            userDefaults.set(value, forKey: key._key)
            return
        }
        
        do {
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(value)
            userDefaults.set(encoded, forKey: key._key)
            userDefaults.synchronize()
        } catch {
            #if DEBUG
                print(error)
            #endif
        }
    }
    
    
    private func isSwiftCodableType<ValueType>(_ type: ValueType.Type) -> Bool {
        switch type {
        case is String.Type, is Bool.Type, is Int.Type, is Float.Type, is Double.Type:
            return true
        default:
            return false
        }
    }
    
    
    private func isFoundationCodableType<ValueType>(_ type: ValueType.Type) -> Bool {
        switch type {
        case is Date.Type:
            return true
        default:
            return false
        }
    }
 
}
