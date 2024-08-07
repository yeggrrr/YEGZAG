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

final class SettingViewController: UIViewController {
    private let settingTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "설정"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        cofigureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DataStorage.userTempProfileImageName = nil
        settingTableView.reloadData()
    }
    
    private func cofigureTableView() {
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
            
            let selectedImage = DataStorage.fetchProfileImage()
            profileCell.profileImageView.image = UIImage(named: selectedImage)
            
            let userName = DataStorage.fetchName()
            profileCell.userNameLabel.text = userName
            
            let joinDate = DataStorage.fetchJoinDate()
            profileCell.joinDateLagel.text = "\(joinDate) 가입"
            
            return profileCell
        } else {
            guard let wishCell = tableView.dequeueReusableCell(withIdentifier: ETCTableViewCell.id, for: indexPath) as? ETCTableViewCell else { return UITableViewCell() }
            wishCell.configureWishListCount(count: RealmManager.shared.fetch().count)
            let option = SettingOptions.allCases[indexPath.row]
            wishCell.wishStackView.isHidden = option != .wishList
            wishCell.wishListLabel.text = option.rawValue
            wishCell.selectionStyle = .none
            return wishCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = NicknameSettingViewController()
            vc.viewType = .update
            vc.saveButtonTintColor = .black
            vc.isSaveButtonEnabled = true
            vc.nicknameSettingView.completeButton.isHidden = true
            vc.nicknameSettingView.nicknameTextField.text = DataStorage.fetchName()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            if indexPath.row == 4 {
                self.showAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?") { _ in
                    for key in UserDefaults.standard.dictionaryRepresentation().keys {
                        UserDefaults.standard.removeObject(forKey: key.description)
                    }
                    
                    self.screenTransition(OnBoardingController())
                }
            }
        }
    }
}
