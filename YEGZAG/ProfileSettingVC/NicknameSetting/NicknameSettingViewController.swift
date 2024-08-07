//
//  NicknameSettingViewController.swift
//  YEGZAG
//
//  Created by YJ on 6/13/24.
//

import UIKit
import SnapKit

final class NicknameSettingViewController: UIViewController {
    let nickNameSettingViewModel = NicknameSettingViewModel()
    
    private let profileImageNameList = Array(0...11).map{ "profile_\($0)" }
    let nicknameSettingView = NicknameSettingView()
    var saveButtonTintColor: UIColor = .clear
    var isSaveButtonEnabled: Bool = false
    var viewType: ViewType = .new

    enum ViewType {
        case new // 처음
        case update // 수정
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
    
    func bindData() {
        nickNameSettingViewModel.outputValidationText.bind { value in
            self.nicknameSettingView.noticeLabel.text = value
        }
        
        nickNameSettingViewModel.outputValidColor.bind { value in
            self.nicknameSettingView.noticeLabel.textColor = value ? .systemBlue : .systemPink
        }
    }
    
    private func setInitialData() {
        if viewType == .new {
            // 최초 진입 or 설정 안하고 pop or 탈퇴후 진입 -> 랜덤으로 가져오기 -> userTempProfileImageName에 임시 저장
            if let randomImageName = profileImageNameList.randomElement() {
                DataStorage.userTempProfileImageName = randomImageName
            }
        } else {
            // 프로필 수정 화면 -> 저장되어있는 닉네임 가져오기
            nicknameSettingView.nicknameTextField.text = DataStorage.fetchName()
        }
    }
    
    private func configureUI() {
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
        nicknameSettingView.nicknameTextField.becomeFirstResponder()
        // profileSettingView
        view.addSubview(nicknameSettingView)
        let safeArea = view.safeAreaLayoutGuide
        nicknameSettingView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
        
        nicknameSettingView.backgroundColor = .white
        // 수정화면
        if let userTempProfileImageName = DataStorage.userTempProfileImageName {
            // 이미지 선택 화면을 진입한 적이 있는 경우
            nicknameSettingView.profileImageView.image = UIImage(named: userTempProfileImageName)
        } else {
            // 프로필 설정화면에 갓 진입한 경우
            nicknameSettingView.profileImageView.image = UIImage(named: DataStorage.fetchProfileImage())
        }
        
        nicknameSettingView.completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
    }
    
    private func profileTabGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        nicknameSettingView.profileTabGestureView.addGestureRecognizer(tapGesture)
        nicknameSettingView.profileTabGestureView.isUserInteractionEnabled = true
    }
    
    @objc func profileImageTapped() {
        let vc = ImageSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func completeButtonClicked() {
        if nickNameSettingViewModel.nicknameErrorMessage == .noError {
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
            
            screenTransition(YEGZAGTabBarController())
        }
    }
    
    @objc func saveButtonClicked() {
        if nickNameSettingViewModel.nicknameErrorMessage == .noError {
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
}

extension NicknameSettingViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        nickNameSettingViewModel.inputText.value = text
        bindData()
    }
}
