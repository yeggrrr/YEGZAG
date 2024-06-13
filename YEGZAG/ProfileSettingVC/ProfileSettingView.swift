//
//  ProfileSettingView.swift
//  YEGZAG
//
//  Created by YJ on 6/13/24.
//

import UIKit
import SnapKit

class ProfileSettingView: UIView {
    let profileView = UIView()
    let profileImageView = UIImageView()
    let profileBorderView = UIView()
    let camerView = UIView()
    let cameraImageView = UIImageView()
    
    let nicknameTextField = UITextField()
    let dividerView = UIView()
    let noticeLabel = NoticeLabel(txt: "닉네임에 @는 입력할 수 없어요", txtColor: .systemPink)
    
    let completeButton = PointButton(title: "완료")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy() {
        addSubview(profileView)
        profileView.addSubview(profileImageView)
        profileImageView.addSubview(profileBorderView)
        
        addSubview(camerView)
        camerView.addSubview(cameraImageView)
        
        addSubview(nicknameTextField)
        addSubview(dividerView)
        addSubview(noticeLabel)
        
        addSubview(completeButton)
    }
    
    func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        profileView.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(150)
        }
        
        profileBorderView.snp.makeConstraints {
            $0.center.equalTo(profileView.snp.center)
            $0.width.height.equalTo(130)
        }
        
        profileImageView.snp.makeConstraints {
            $0.center.equalTo(profileBorderView.snp.center)
            $0.width.height.equalTo(100)
        }
        
        camerView.snp.makeConstraints {
            $0.trailing.equalTo(profileBorderView.snp.trailing)
            $0.bottom.equalTo(profileBorderView.snp.bottom)
            $0.width.height.equalTo(40)
        }
        
        cameraImageView.snp.makeConstraints {
            $0.center.equalTo(camerView.snp.center)
            $0.width.height.equalTo(22)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeArea).inset(10)
            $0.height.equalTo(50)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea).inset(10)
            $0.height.equalTo(1)
        }
        
        noticeLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(safeArea).inset(20)
            $0.height.equalTo(30)
        }
        
        completeButton.snp.makeConstraints {
            $0.top.equalTo(noticeLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(safeArea).inset(10)
            $0.height.equalTo(50)
        }
    }
    
    func configureUI() {
        profileView.backgroundColor = .white
        
        profileBorderView.layer.cornerRadius = 65
        profileBorderView.layer.borderWidth = 3
        profileBorderView.layer.borderColor = UIColor.systemPink.cgColor
        profileBorderView.alpha = 100
        
        profileImageView.image = UIImage(named: UIImage.random())
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        
        camerView.layer.cornerRadius = 20
        camerView.backgroundColor = .systemPink
        
        cameraImageView.image = UIImage(systemName: "camera.fill")
        cameraImageView.tintColor = .white
        cameraImageView.layer.cornerRadius = 11
        
        nicknameTextField.setProfileSettingTextField(placeholderText: "닉네임을 입력해주세요 :)")
        
        dividerView.backgroundColor = .systemGray4
    }
}
