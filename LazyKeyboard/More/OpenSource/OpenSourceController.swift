//
//  OpenSourceController.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/3/3.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit

class OpenSourceController: UITableViewController {

    private var viewModel = OpenSourceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: UITableViewCell.self)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 10))
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
    }
}

extension OpenSourceController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = viewModel.list[indexPath.row]["title"]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = viewModel.list[indexPath.row]["address"]
        let url: URL = URL(string: str!)!
        let web = WebController()
        web.title = viewModel.list[indexPath.row]["title"]
        web.webURL = url
        self.navigationController?.pushViewController(web, animated: true)
    }
}
