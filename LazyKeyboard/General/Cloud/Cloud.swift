//
//  CloudKit.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/3/5.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit
import CloudKit

final class Cloud {
    
    // 单例
    static let shared = Cloud()
    private init() {
        CKContainer.default().accountStatus {[weak self] (status, error) in
//            guard let `self` = self else { return }
            guard let _ = self else { return }
            if status == CKAccountStatus.available {
                print("Easy, my boy. Your iColud is available.")
            } else {
                print("Easy, my boy. You haven't logged into iCloud account on your device/simulator yet.")
            }
        }
    }
    
    private let container = CKContainer.default()
    private let publicDatabase = CKContainer.default().publicCloudDatabase
    private let privateDatabase = CKContainer.default().privateCloudDatabase
    private let recordID = CKRecordID(recordName: "SyllableListt")
    
    
    func addToCloud() {
        // 创建 record Object
        let artworkRecord = CKRecord(recordType: "Syllable", recordID: recordID)
        
        artworkRecord["SyllableList"] = ["这是一条字段" as NSString] as [NSString] as CKRecordValue
        artworkRecord["type"] = "default" as NSString
        
        privateDatabase.save(artworkRecord) { (record, err) in
            if let err = err {
                print(err)
                return
            }
            // success
            print("success")
        }
    }
    
    func queryFromCloud() {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Syllable", predicate: predicate)
        
        privateDatabase.perform(query, inZoneWith: nil) { (record, err) in
            if let err = err {
                print(err)
                return
            }
//            print(record![0].object(forKey: "SyllableList"))
        }
    }
    
    
    func fetchSettingFromCloud(_ callback: @escaping (SettingConfig?) -> ()) {

        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Setting", predicate: predicate)
        privateDatabase.perform(query, inZoneWith: nil) { (record, err) in
            
            if (record?.count).or(0)! > 0 {
                // 处理
                let set = SettingConfig()
                let rec = record![0]
                set.isICloudAllowed = rec.object(forKey: "isICloudAllowed") as! Int == 1
                set.isLongPressSpaceToMainApp = rec.object(forKey: "isLongPressSpaceToMainApp") as! Int == 1
                set.isPressShake = rec.object(forKey: "isLongPressSpaceToMainApp") as! Int == 1
                set.isSendAfterSelected = rec.object(forKey: "isLongPressSpaceToMainApp") as! Int == 1
                callback(set)
            } else {
                callback(nil)
            }
        }
    }
    
    func syncSettingsToCloud() {
        
    }
    
}
