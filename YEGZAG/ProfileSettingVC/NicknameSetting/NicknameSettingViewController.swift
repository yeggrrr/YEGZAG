//
//  NicknameSettingViewController.swift
//  YEGZAG
//
//  Created by YJ on 6/13/24.
//

import UIKit
import SnapKit

class NicknameSettingViewController: UIViewController {
    let nicknameSettingView = NicknameSettingView()
    var profileImageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeRandomProfileImageName()
        configureUI()
        profileTabGesture()
    }
    
    func configureUI() {
        // view
        view.backgroundColor = .white
        // navigation
        navigationItem.title = "프로필 설정"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        // profileSettingView
        view.addSubview(nicknameSettingView)
        
        let safeArea = view.safeAreaLayoutGuide
        nicknameSettingView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
        
        nicknameSettingView.backgroundColor = .white
        
        if let profileImageName = profileImageName {
            nicknameSettingView.profileImageView.image = UIImage(named: profileImageName)
        } else {
            nicknameSettingView.profileImageView.image = UIImage(resource: .profile0)
        }
    }
    
    func makeRandomProfileImageName() {
        profileImageName = DataStorage.profileImageNameList.randomElement()
    }
    
    
    func profileTabGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        nicknameSettingView.profileTabGestureView.addGestureRecognizer(tapGesture)
        nicknameSettingView.profileTabGestureView.isUserInteractionEnabled = true
    }
    
    @objc func profileImageTapped() {
        let vc = ImageSettingViewController()
        vc.currentProfileImageName = profileImageName
        navigationController?.pushViewController(vc, animated: true)
    }
}
