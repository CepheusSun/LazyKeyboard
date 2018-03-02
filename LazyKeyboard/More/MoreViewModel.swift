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
    
    lazy var list: [MoreSection] =
        [
            MoreSection(header: "帮助", footer: "如果无法正常开启, 请自行前往”设置-通用-键盘-添加新键盘“进行设置。", items: [
                MoreItem(title: "开启键盘", showMore: true, message: nil, switchState: nil) {
                    let url = URL(string: UIApplicationOpenSettingsURLString)!
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }]),
            
            MoreSection(header: nil, footer: nil, items: [
                MoreItem(title: "Premium版功能", showMore: true, message: nil, switchState: nil) {}]),
            
            MoreSection(header: "偏好设置", footer: nil, items: [
                MoreItem(title: "按键震动", showMore: nil, message: nil, switchState: true) {},
                MoreItem(title: "长按空格键跳转至主应用", showMore: nil, message: nil, switchState: true){},
                MoreItem(title: "选择后直接发送", showMore: nil, message: nil, switchState: true){}]),
            
            MoreSection(header: nil, footer: "在键盘上长按回车即可打开。请勿过于依赖此功能", items: [
                MoreItem(title: "关于自动回车", showMore: nil, message: nil, switchState: nil){}]),
            
            MoreSection(header: nil, footer: nil, items: [
                MoreItem(title: "分享应用", showMore: true, message: nil, switchState: nil){[unowned self] in
                    self.controller?.loadShare()
                },
                MoreItem(title: "去 App Store 评分", showMore: true, message: nil, switchState: nil){[unowned self] in
                    self.controller?.loadAppStoreController()
                }]),
            
            MoreSection(header: "反馈", footer: nil, items: [
                MoreItem(title: "iMessage", showMore: nil, message: "624162319@qq.com", switchState: nil){[unowned self] in
                    self.controller?.loadIMessageController()
                },
                MoreItem(title: "邮件", showMore: nil, message: "CepheusSun@gmail.com", switchState: nil){[unowned self] in
                    self.controller?.loadEmailController()
                }]),
            
            MoreSection(header: "关注作者", footer: "Copyright © 2018 CepheusSun", items: [
                MoreItem(title: "Twitter", showMore: nil, message: "@CepheusSun_", switchState: nil){[unowned self] in
                    self.controller?.goToSocialNetwork(weibo: false)
                },
                MoreItem(title: "Weibo", showMore: nil, message: "@CepheusSun", switchState: nil){[unowned self] in
                    self.controller?.goToSocialNetwork(weibo: true)
                }])
        ]


}
