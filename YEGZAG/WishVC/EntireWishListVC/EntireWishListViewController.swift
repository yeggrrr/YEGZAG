//
//  EntireWishListViewController.swift
//  YEGZAG
//
//  Created by YJ on 7/9/24.
//

import UIKit
import SnapKit

class EntireWishListViewController: UIViewController {
    let itemListTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureTableView()
    }
    
    func configureHierarchy() {
        view.addSubview(itemListTableView)
    }
    
    func configureLayout() {
        itemListTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
    }
    
    func configureTableView() {
        itemListTableView.delegate = self
        itemListTableView.dataSource = self
        itemListTableView.register(EntireWishListTableViewCell.self, forCellReuseIdentifier: EntireWishListTableViewCell.id)
    }
    
}

extension EntireWishListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EntireWishListTableViewCell.id, for: indexPath) as? EntireWishListTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    
}
