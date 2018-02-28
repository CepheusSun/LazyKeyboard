//
//  ViewController.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/2/28.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    private var viewModel = HomeViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputContentView: UIView!
    
    var keyBoardNeedLayout: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(cellType: UITableViewCell.self)
        
        NotificationCenter.default
            .addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                         name: .UIKeyboardWillShow, object: nil)

        NotificationCenter.default
            .addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                         name: .UIKeyboardWillHide, object: nil)
        
    }
    
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func hideKeyboardAction(_ sender: Any) {
        self.resignFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)

    }
}

extension HomeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = viewModel.list[indexPath.row]
        return cell
    }
}

extension HomeController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo,
           let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
           let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
           let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            let deltaY = intersection.height
            UIView.animate(withDuration: duration, delay: 0.0,
                           options: UIViewAnimationOptions(rawValue: curve),
                           animations: {
                            self.inputContentView.frame = CGRect(x: 0, y: deltaY, width: self.view.bounds.width, height: 44)
                            self.keyBoardNeedLayout = true
                            self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
    }

}

