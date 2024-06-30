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
    let profileImageNameList = Array(0...11).map{ "profile_\($0)" }
    
    enum ViewType {
        case new // 처음
        case update // 수정
    }
    
    enum NicknameErrorMessage: String {
        case empty = ""
        case wrongLength = "2글자 이상 10글자 미만으로 설정해주세요"
        case containsSpecialCharacter = "닉네임에 @, #, $, %는 포함할 수 없어요"
        case containsNumber = "닉네임에 숫자는 포함할 수 없어요"
        case noError = "사용할 수 있는 닉네임이에요"
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
            // 최초 진입 or 설정 안하고 pop or 탈퇴후 진입 -> 랜덤으로 가져오기 -> userTempProfileImageName에 임시 저장
            if let randomImageName = profileImageNameList.randomElement() {
                DataStorage.userTempProfileImageName = randomImageName
            }
        } else {
            // 프로필 수정 화면 -> 저장되어있는 닉네임 가져오기
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
        // 현재 날짜 가져오기 -> 가입일
        let joinDate = DateFormatter.dotDateFormatter.string(from: Date())
        DataStorage.save(value: joinDate, key: .joinDate)
        if let userName = nicknameSettingView.nicknameTextField.text {
            DataStorage.save(value: userName, key: .name)
        }
        
        DataStorage.save(value: true, key: .isExistUser)
        
        if let userTempProfileImageName = DataStorage.userTempProfileImageName {
            // 설정한 프로필 이미지 UserDefaults에 저장
            DataStorage.save(value: userTempProfileImageName, key: .profileImage)
            // 임시저장소 비우기
            DataStorage.userTempProfileImageName = nil
        }
        
        screenTransition(YEGZAGTabBarController())
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
