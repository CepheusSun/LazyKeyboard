//
//  ViewController.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/2/28.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit
import RxSwift

class SyllableController: UIViewController {

    private var viewModel = SyllableViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputContentViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!
    
    var aliasTextField: UITextField!

    // 当前正在编辑的字段, 如果是新增, 该字段为nil
    var currentEditedIndex: Int?
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(cellType: SyllableTableViewCell.self)
        automaticallyAdjustsScrollViewInsets = false
        NotificationCenter.default
            .addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                         name: .UIKeyboardWillShow, object: nil)

        NotificationCenter.default
            .addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                         name: .UIKeyboardWillHide, object: nil)
        
        configLongPress()
        
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
extension SyllableController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SyllableTableViewCell.self)
        cell.model = viewModel.list[indexPath.row];
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
            self.textField.text = self.viewModel.list[indexPath.row].content
            self.addAction(self.navigationItem.rightBarButtonItem!)
        }
        return [delete, edit]
    }
}

extension SyllableController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - 键盘
extension SyllableController: UITextFieldDelegate {
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
                self.viewModel.editSyllable(textField.text!, at: $0)
            }.ifNone {[unowned self, textField] in
                self.viewModel.addSyllable(textField.text!)
            }
        textField.text = ""
        currentEditedIndex = nil
        return true
    }
    
}

//单个 cell 的长按手势
extension SyllableController {
    
    private func configLongPress() {
        let ges = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressAction(_:)))
        ges.minimumPressDuration = 0.6
        tableView.addGestureRecognizer(ges)
    }
    
    @objc private func longPressAction(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let point = gesture.location(in: tableView)
            let indexPath = tableView.indexPathForRow(at: point)
            if indexPath.hasSome {
                let alert = UIAlertControllerStyle.actionSheet.controller(title: nil, message: nil, actions:
                    [
//                        "移动到其他分组".alertAction(style: .default, handler: {_ in
//                            // TDO: 移动分组
//                        }),
                        "设置别名".alertAction(style: .default, handler: {_ in
                            self.setAlias(indexPath!)
                        }),
                        "取消".alertAction(style: .cancel, handler: nil)
                    ])
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func setAlias(_ indexPath: IndexPath) {
        
        let alert = UIAlertControllerStyle.alert.controller(title: nil, message: "设置别名", actions:
            [
                "取消".alertAction(style: .cancel, handler: nil),
                "确定".alertAction(style: .default, handler: { _ in
                    self.viewModel.editSyllableAlias(self.aliasTextField.text, at: indexPath.row)
                })
            ])
        alert.addTextField {
            self.aliasTextField = $0
        }
        self.present(alert, animated: true, completion: nil)
    }
}

