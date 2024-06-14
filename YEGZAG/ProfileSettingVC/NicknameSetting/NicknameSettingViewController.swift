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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeRandomProfileImageName()
        configureUI()
        profileTabGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }
    
    func configureUI() {
        // view
        view.backgroundColor = .white
        // navigation
        navigationItem.title = "프로필 설정"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        // textField
        nicknameSettingView.nicknameTextField.delegate = self

        // profileSettingView
        view.addSubview(nicknameSettingView)
        
        let safeArea = view.safeAreaLayoutGuide
        nicknameSettingView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
        
        nicknameSettingView.backgroundColor = .white
        
        if let profileImageName = DataStorage.userProfileImageName {
            nicknameSettingView.profileImageView.image = UIImage(named: profileImageName)
        } else {
            nicknameSettingView.profileImageView.image = UIImage(resource: .profile0)
        }
        
        // completButton
        nicknameSettingView.completeButton.isEnabled = false
        nicknameSettingView.completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
    }
    
    func makeRandomProfileImageName() {
        DataStorage.userProfileImageName = DataStorage.profileImageNameList.randomElement()
    }
    
    func nicknameCondition() {
        guard let text  = nicknameSettingView.nicknameTextField.text else { return }
        for char in text {
            if text.isEmpty {
                nicknameSettingView.noticeLabel.text = ""
            } else if text.count < 2 || text.count > 10 {
                nicknameSettingView.noticeLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
            } else if text.contains("@") || text.contains("#") || text.contains("$") || text.contains("%") {
                nicknameSettingView.noticeLabel.text = "닉네임에 @, #, $, %는 포함할 수 없어요"
            } else if Int(String(char)) != nil {
                nicknameSettingView.noticeLabel.text = "닉네임에 숫자는 포함할 수 없어요"
            } else {
                nicknameSettingView.noticeLabel.text = "사용할 수 있는 닉네임이에요"
                nicknameSettingView.completeButton.isEnabled = true
            }
        }
    }
    
    func profileTabGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        nicknameSettingView.profileTabGestureView.addGestureRecognizer(tapGesture)
        nicknameSettingView.profileTabGestureView.isUserInteractionEnabled = true
    }
    
    @objc func profileImageTapped() {
        let vc = ImageSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func completeButtonClicked() {
        DataStorage.userName = nicknameSettingView.nicknameTextField.text
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate

        let vc = YEGZAGTabBarController()
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}

extension NicknameSettingViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        nicknameCondition()
    }
}
