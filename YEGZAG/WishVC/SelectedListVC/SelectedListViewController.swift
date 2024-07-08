//
//  SelectedListViewController.swift
//  YEGZAG
//
//  Created by YJ on 7/8/24.
//

import UIKit
import SnapKit

class SelectedListViewController: UIViewController {
    let listTableView = UITableView()
    
    var folderList: [Folder] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        folderList = RealmManager.shared.fetchFolder()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureTableView()
    }
    
    func configureHierarchy() {
        view.addSubview(listTableView)
    }
    
    func configureLayout() {
        listTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI()  {
        view.backgroundColor = .white
        title = "찜 카테고리"
    }
    
    func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(SelectedListTableViewCell.self, forCellReuseIdentifier: SelectedListTableViewCell.id)
    }
}

extension SelectedListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectedListTableViewCell.id, for: indexPath) as? SelectedListTableViewCell else { return UITableViewCell() }
        let item = folderList[indexPath.row]
        cell.titleLabel.text = item.name
        cell.countLabel.text = "(\(item.detail.count))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WishViewController()
        let item = folderList[indexPath.row]
        vc.folder = item
        navigationController?.pushViewController(vc, animated: true)
    }
}
