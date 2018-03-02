//
//  MoreController.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/2/28.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI

class MoreController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel: MoreViewModel = MoreViewModel(controller: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(cellType: MoreTableViewCell.self)
        
    }
}

extension MoreController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as MoreTableViewCell
        let item: MoreItem = viewModel.list[indexPath.section].items[indexPath.row]
        cell.item = item
        if item.switchState.hasSome {
            cell.switchValueChangedCallback = { [unowned self] in
                self.viewModel.list[indexPath.section].items[indexPath.row].toggle($0)
                item.action()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return viewModel.list[section].footer
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.list[section].header
    }
}

extension MoreController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item: MoreItem = viewModel.list[indexPath.section].items[indexPath.row]
        item.action()
    }
    
}

// MARK: - Premium
extension MoreController {
    func loadPremium() {
        present(UINavigationController(rootViewController: PremiumController()), animated: true, completion: nil)
    }
}

// MARK: - 分享
extension MoreController {
    func loadShare() {
        let share = UIActivityViewController(activityItems: ["懒人键盘", URL(string: C.appStoreUrl)!], applicationActivities: nil)
        present(share, animated: true, completion: nil)
    }
}

// MARK: - 跳转 App Store
extension MoreController: SKStoreProductViewControllerDelegate {
    func loadAppStoreController() {
        let store = SKStoreProductViewController()
        store.delegate = self
        store.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: "1354448059"]) { (isSuccess, error) in
            if isSuccess {
                self.present(store, animated: true, completion: nil)
            }
        }
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}


// MARK: - 跳转发邮件
extension MoreController: MFMailComposeViewControllerDelegate {

    func loadEmailController() {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.setSubject("")
            mail.setToRecipients(["CepheusSun@gmail.com"])
            mail.mailComposeDelegate = self
            self.navigationController?.present(mail, animated: true, completion: nil)
        } else {
            self.openUrl(URL(string: "mailto:CepheusSun@gmail.com")!)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func openUrl(_ url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

// MARK: - 跳转发短信
extension MoreController: MFMessageComposeViewControllerDelegate {
    func loadIMessageController() {
        
        if MFMessageComposeViewController.canSendText() {
            let mail = MFMessageComposeViewController()
            mail.recipients = ["624162319@qq.com"]
            mail.messageComposeDelegate = self
            self.navigationController?.present(mail, animated: true, completion: nil)
        } else {
            self.openUrl(URL(string: "sms:624162319@qq.com")!)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension MoreController {
    func goToSocialNetwork(weibo: Bool) {
        if weibo {
            self.openUrl(URL(string: "sinaweibo://userinfo?uid=2453750463")!)
        } else {
            self.openUrl(URL(string: "twitter://user?screen_name=CepheusSun")!)
        }
    }
}
