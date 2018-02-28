//
//  ViewController.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/2/28.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit
import RxSwift

class HomeController: UIViewController {

    private var viewModel = HomeViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputContentViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(cellType: UITableViewCell.self)
        
        NotificationCenter.default
            .addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                         name: .UIKeyboardWillShow, object: nil)

        NotificationCenter.default
            .addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                         name: .UIKeyboardWillHide, object: nil)
        
        
        viewModel.output.asObserver()
            .subscribe(onNext: {[weak self] _ in
                self?.tableView.reloadData()
            }).disposed(by: bag)
    }
    
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func hideKeyboardAction(_ sender: Any) {
        textField.resignFirstResponder()
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: - 键盘
extension HomeController: UITextFieldDelegate {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo,
           let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
           let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            let deltaY = intersection.height
            UIView.animate(withDuration: 0.3, delay: 0.0,
                           options: UIViewAnimationOptions(rawValue: curve),
                           animations: {
                            self.inputContentViewTopConstraint.constant = -deltaY-44;
            }, completion: nil)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            UIView.animate(withDuration: 0.3, delay: 0.0,
                           options: UIViewAnimationOptions(rawValue: curve),
                           animations: {
                            self.inputContentViewTopConstraint.constant = 0;
            }, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.viewModel.addSyllable(textField.text!)
        textField.text = ""
        return true
    }
    
}

