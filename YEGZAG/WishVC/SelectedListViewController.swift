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
    
    let tableList: [listType] = [.jim, .clothes, .interier, .cosmetics]
    
    enum listType: String, CaseIterable {
        case jim = "찜"
        case clothes = "의류"
        case interier = "인테리어"
        case cosmetics = "메이크업"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return tableList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectedListTableViewCell.id, for: indexPath) as? SelectedListTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = listType.allCases[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WishViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
