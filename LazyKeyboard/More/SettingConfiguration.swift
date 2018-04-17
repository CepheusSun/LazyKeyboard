//
//  SettingConfiguration.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/3/2.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import Foundation

struct App {
    
    static func getSettingConfig() -> SettingConfig {
        let user = Defaults(userDefaults: C.groupUserDefaults!)
        let key = Key<SettingConfig>("SettingConfiguration")
        return user.get(for: key).or(SettingConfig())!
    }
    
    static func isSettingExist() -> Bool {
        let user = Defaults(userDefaults: C.groupUserDefaults!)
        let key = Key<SettingConfig>("SettingConfiguration")
        return user.get(for: key).hasSome
    }
    
    static func save(settingConfig: SettingConfig) {
        let user = Defaults(userDefaults: C.groupUserDefaults!)
        let key = Key<SettingConfig>("SettingConfiguration")
        user.set(settingConfig, for: key)
    }
}

final class SettingConfig: Codable {
    
    var isPressShake: Bool = false {
        didSet {
            App.save(settingConfig: self)
        }
    }
    var isLongPressSpaceToMainApp: Bool = true {
        didSet {
            App.save(settingConfig: self)
        }
    }
    
    var isSendAfterSelected: Bool = false {
        didSet {
            App.save(settingConfig: self)
        }
    }

    var isAliasSendAfterSelected: Bool = false {
        didSet {
            App.save(settingConfig: self)
        }
    }
    
    var isICloudAllowed: Bool = false {
        didSet {
            App.save(settingConfig: self)
        }
    }
    
}
