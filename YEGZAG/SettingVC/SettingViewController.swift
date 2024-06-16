//
//  SettingViewController.swift
//  YEGZAG
//
//  Created by YJ on 6/14/24.
//

import UIKit
import SnapKit

enum SettingOptions: String, CaseIterable {
    case wishList = "나의 장바구니 목록"
    case frequentlyQuestions = "자주 묻는 질문"
    case personalInquiry = "1:1 문의"
    case notificationSettings = "알림 설정"
    case unsubscribe = "탈퇴하기"
}

class SettingViewController: UIViewController {
    let settingTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "SETTING"
        cofigureTableView()
    
    }
    
    func cofigureTableView() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.id)
        settingTableView.register(ETCTableViewCell.self, forCellReuseIdentifier: ETCTableViewCell.id)
        
        view.addSubview(settingTableView)
        let safeArea = view.safeAreaLayoutGuide
        settingTableView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 130
        } else {
            return 50
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return SettingOptions.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let profileCell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
            profileCell.selectionStyle = .none
            return profileCell
        } else {
            guard let wishCell = tableView.dequeueReusableCell(withIdentifier: ETCTableViewCell.id, for: indexPath) as? ETCTableViewCell else { return UITableViewCell() }
            wishCell.wishListLabel.text = SettingOptions.allCases[indexPath.row].rawValue
            wishCell.selectionStyle = .none
            if indexPath.row > 0 {
                wishCell.wishStackView.isHidden  = true
            }
            return wishCell
        }
    }
}
