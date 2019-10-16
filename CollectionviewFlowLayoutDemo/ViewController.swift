//
//  ViewController.swift
//  CollectionviewFlowLayoutDemo
//
//  Created by Dylan Chen on 2019/10/15.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    static let cellIdentifity = "UITableViewCell"
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: ViewController.cellIdentifity)

        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(ListViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(BannerViewController(), animated: true)
        default:
            return
        }
    }
    
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellIdentifity, for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = " 左侧布局 "
        case 1:
            cell.textLabel?.text = " banner "
        default:
            break
        }
        return cell
    }
}
