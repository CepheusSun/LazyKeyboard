//
//  HomeController.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/4/18.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit
import RxSwift


class HomeController: UIViewController {
    // perform Segue 用
    var selectedIndex: Int?
    
    private var viewModel = HomeViewModel()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputContentViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!
    
    var bag = DisposeBag()

    // 当前正在编辑的字段, 如果是新增, 该字段为nil
    var currentEditedIndex: Int?
    
    static let cellIndetifier = "UITableViewCellHomeIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: HomeController.cellIndetifier)
        automaticallyAdjustsScrollViewInsets = false
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

    
    
    var editionStatus = false
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            sender.title = "编辑"
            return
        }
        
        tableView.setEditing(false, animated: true)
        editionStatus = !editionStatus
        sender.title = editionStatus ? "完成" : "编辑"
        tableView.setEditing(editionStatus, animated: true)
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

// MARK: - TableView
extension HomeController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeController.cellIndetifier, for: indexPath)
        cell.textLabel?.text = viewModel.list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.move(sourceIndexPath, to: destinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "删除") {[unowned self] (action, indexPath) in
            self.viewModel.delete(indexPath)
        }
        let edit = UITableViewRowAction(style: .normal, title: "编辑") {[unowned self] (action, indexPath) in
            self.currentEditedIndex = indexPath.row
            self.textField.text = self.viewModel.list[indexPath.row]
            self.addAction(self.navigationItem.rightBarButtonItem!)
        }
        return [delete, edit]
    }
}

extension HomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "toSyllableList", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSyllableList" {
            let vc: SyllableController = segue.destination as! SyllableController
            vc.type = viewModel.list[selectedIndex.or(0)]
            vc.typeList = viewModel.list
            selectedIndex = nil
        }
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
        
        if textField.text! == "" {
            return true
        }
        currentEditedIndex
            .ifSome { [unowned self, textField] in
                self.viewModel.edit(textField.text!, at: $0)
            }.ifNone {[unowned self, textField] in
                self.viewModel.add(textField.text!)
        }
        textField.text = ""
        currentEditedIndex = nil
        return true
    }
}
