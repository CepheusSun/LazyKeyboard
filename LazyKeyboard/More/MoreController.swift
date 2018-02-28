//
//  MoreController.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/2/28.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit

class MoreController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = MoreViewModel()
    
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
