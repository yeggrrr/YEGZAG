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
    var saveButtonTintColor: UIColor = .clear
    var isSaveButtonEnabled: Bool = false
    var nicknameErrorMessage: NicknameErrorMessage = .empty
    var viewType: ViewType = .new
    
    enum ViewType {
        case new
        case update
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        profileTabGesture()
        setInitialData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    func setInitialData() {
        if viewType == .new {
            if let randomImageName = DataStorage.profileImageNameList.randomElement() {
                DataStorage.userTempProfileImageName = randomImageName
            }
        } else {
            nicknameSettingView.nicknameTextField.text = DataStorage.fetchName()
        }
    }
    
    func configureUI() {
        // view
        view.backgroundColor = .white
        // navigation
        navigationItem.title = "프로필 설정"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        
        let rightsaveButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = rightsaveButtonItem
        rightsaveButtonItem.tintColor = saveButtonTintColor
        rightsaveButtonItem.isEnabled = isSaveButtonEnabled
        // textField
        nicknameSettingView.nicknameTextField.delegate = self
        // profileSettingView
        view.addSubview(nicknameSettingView)
        
        let safeArea = view.safeAreaLayoutGuide
        nicknameSettingView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
        
        nicknameSettingView.backgroundColor = .white
        
        if let userTempProfileImageName = DataStorage.userTempProfileImageName {
            nicknameSettingView.profileImageView.image = UIImage(named: userTempProfileImageName)
        } else {
            nicknameSettingView.profileImageView.image = UIImage(named: DataStorage.fetchProfileImage())
        }
        
        nicknameSettingView.completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
    }
    
    func nicknameCondition() {
        guard let text  = nicknameSettingView.nicknameTextField.text else { return }
        for char in text {
            if text.isEmpty {
                nicknameErrorMessage = .empty
            } else if text.count < 2 || text.count > 10 {
                nicknameErrorMessage = .wrongLength
            } else if text.contains("@") || text.contains("#") || text.contains("$") || text.contains("%") {
                nicknameErrorMessage = .containsSpecialCharacter
            } else if Int(String(char)) != nil {
                nicknameErrorMessage = .containsNumber
            } else {
                nicknameErrorMessage = .noError
            }
        }
        
        nicknameSettingView.noticeLabel.text = nicknameErrorMessage.rawValue
    }
    
    enum NicknameErrorMessage: String {
        case empty = ""
        case wrongLength = "2글자 이상 10글자 미만으로 설정해주세요"
        case containsSpecialCharacter = "닉네임에 @, #, $, %는 포함할 수 없어요"
        case containsNumber = "닉네임에 숫자는 포함할 수 없어요"
        case noError = "사용할 수 있는 닉네임이에요"
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
        guard nicknameErrorMessage == .noError else { return }
        
        let joinDate = DateFormatter.dotDateFormatter.string(from: Date())
        DataStorage.save(value: joinDate, key: .joinDate)
        if let userName = nicknameSettingView.nicknameTextField.text {
            DataStorage.save(value: userName, key: .name)
        }
        DataStorage.save(value: true, key: .isExistUser)
        
        if let userTempProfileImageName = DataStorage.userTempProfileImageName {
            DataStorage.save(value: userTempProfileImageName, key: .profileImage)
            DataStorage.userTempProfileImageName = nil
        }
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let vc = YEGZAGTabBarController()
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    @objc func saveButtonClicked() {
        guard nicknameErrorMessage == .noError else { return }
        
        if let userTempProfileImageName = DataStorage.userTempProfileImageName {
            DataStorage.save(value: userTempProfileImageName, key: .profileImage)
            DataStorage.userTempProfileImageName = nil
        }
        
        if let userName = nicknameSettingView.nicknameTextField.text {
            DataStorage.save(value: userName, key: .name)
        }
        
        navigationController?.popViewController(animated: true)
    }
}

extension NicknameSettingViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        nicknameCondition()
    }
}
