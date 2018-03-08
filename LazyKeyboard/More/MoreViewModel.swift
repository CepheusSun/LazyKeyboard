//
//  MoreViewModel.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/2/28.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit

final class MoreViewModel {
    
    weak var controller: MoreController?

    init(controller: MoreController) {
        self.controller = controller
    }
    
    let setting = App.getSettingConfig()
    
    lazy var list: [MoreSection] =
        [
            MoreSection(header: "帮助", footer: "如果无法正常开启, 请自行前往”设置-通用-键盘-添加新键盘“进行设置。", items: [
                MoreItem(title: "开启键盘", showMore: true, message: nil, switchState: nil) {
                    
                    if #available(iOS 11.0, *) {
                        let url = URL(string: UIApplicationOpenSettingsURLString)!
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        let url: URL = "App-Prefs:root=General&path=Keyboard"
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }]),
            
//            MoreSection(header: nil, footer: nil, items: [
//                MoreItem(title: "Premium版功能", showMore: true, message: nil, switchState: nil) {[unowned self] in
//                    self.controller?.loadPremium()
//                }]),
            
            MoreSection(header: "偏好设置", footer: nil, items: [
                MoreItem(title: "按键音", showMore: nil, message: nil, switchState: self.setting.isPressShake) {[unowned self] in
                    self.setting.isPressShake = !self.setting.isPressShake
                },
                MoreItem(title: "长按空格键跳转至主应用", showMore: nil, message: nil, switchState: self.setting.isLongPressSpaceToMainApp){[unowned self] in
                    self.setting.isLongPressSpaceToMainApp = !self.setting.isLongPressSpaceToMainApp
                },
                MoreItem(title: "选择后直接发送", showMore: nil, message: nil, switchState: self.setting.isSendAfterSelected){[unowned self] in
                    self.setting.isSendAfterSelected = !self.setting.isSendAfterSelected
                }]),
            
//            MoreSection(header: nil, footer: "在键盘上长按回车即可打开。请勿过于依赖此功能。", items: [
//                MoreItem(title: "关于自动回车", showMore: nil, message: nil, switchState: nil){}]),
    
            MoreSection(header: "支持", footer: "您的支持才是我坚持下去的动力。", items: [
                MoreItem(title: "分享应用", showMore: true, message: nil, switchState: nil){[unowned self] in
                    self.controller?.loadShare()
                },
                MoreItem(title: "去 App Store 评分", showMore: true, message: nil, switchState: nil){[unowned self] in
                    self.controller?.loadAppStoreController()
                }]),
            
//            MoreSection(header: "iCloud", footer: nil, items: [
//                MoreItem(title: "使用 iCloud", showMore: nil, message: nil, switchState: nil){[unowned self] in
//                    self.setting.isICloudAllowed = !self.setting.isICloudAllowed
//                },
//                MoreItem(title: "同步设置", showMore: nil, message: nil, switchState: nil){[unowned self] in
//                    self.controller?.syncICloud()
//                }]),
            
            MoreSection(header: "反馈", footer: nil, items: [
                MoreItem(title: "iMessage", showMore: nil, message: "", switchState: nil){[unowned self] in
                    self.controller?.loadIMessageController()
                },
                MoreItem(title: "邮件", showMore: nil, message: "CepheusSun@gmail.com", switchState: nil){[unowned self] in
                    self.controller?.loadEmailController()
                }]),
            
            MoreSection(header: nil, footer: "感谢开源世界的前辈们👍🏻", items: [
                MoreItem(title: "致敬开源社区", showMore: true, message: nil, switchState: nil){[unowned self] in
                    self.controller?.goToOpenSourceLicense()
                }]),
            
            MoreSection(header: "关注作者", footer: self.getVersion(), items: [
                MoreItem(title: "Twitter", showMore: nil, message: "@CepheusSun_", switchState: nil){[unowned self] in
                    self.controller?.goToSocialNetwork(weibo: false)
                },
                MoreItem(title: "Weibo", showMore: nil, message: "@CepheusSun", switchState: nil){[unowned self] in
                    self.controller?.goToSocialNetwork(weibo: true)
                }])
        ]
    
    func getVersion() -> String {
        let infoDictionary = Bundle.main.infoDictionary!
        let appVersion = infoDictionary["CFBundleShortVersionString"]!
        // 获取App的build版本
        let appBuildVersion = infoDictionary["CFBundleVersion"]!
        return "当前版本 " + "\(appVersion)" + "(\(appBuildVersion))" + " 🌟 " + "Made by CepheusSun"
    }
}
