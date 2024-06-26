//
//  NicknameSettingView.swift
//  YEGZAG
//
//  Created by YJ on 6/13/24.
//

import UIKit
import SnapKit

final class NicknameSettingView: UIView {
    private let profileView = UIView()
    private let profileBorderView = UIView()
    private let camerView = UIView()
    private let cameraImageView = UIImageView()
    let nicknameTextField = UITextField()
    private let dividerView = UIView()
    let noticeLabel = UILabel()
    let completeButton = PointButton(title: "완료")
    let profileTabGestureView = UIView()
    
    var profileImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        addSubview(profileView)
        profileView.addSubview(profileBorderView)
        profileBorderView.addSubview(profileImageView)
        
        addSubview(camerView)
        camerView.addSubview(cameraImageView)
        addSubview(profileTabGestureView)
        
        addSubview(nicknameTextField)
        addSubview(dividerView)
        addSubview(noticeLabel)
        
        addSubview(completeButton)
    }
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        profileView.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(150)
        }
        
        profileBorderView.snp.makeConstraints {
            $0.center.equalTo(profileView.snp.center)
            $0.width.height.equalTo(100)
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
        
        profileTabGestureView.snp.makeConstraints {
            $0.edges.equalTo(profileBorderView)
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
    
    private func configureUI() {
        profileView.backgroundColor = .white
        
        profileBorderView.layer.borderWidth = 3
        profileBorderView.layer.borderColor = UIColor.primaryColor.cgColor
        
        profileBorderView.layoutIfNeeded()
        profileBorderView.layer.cornerRadius = profileBorderView.frame.width / 2
        profileBorderView.clipsToBounds = true
        
        profileImageView.contentMode = .scaleAspectFill
        
        camerView.layer.cornerRadius = 20
        camerView.backgroundColor = .primaryColor
        
        cameraImageView.image = UIImage(systemName: "camera.fill")
        cameraImageView.tintColor = .white
        cameraImageView.layer.cornerRadius = 11
        
        nicknameTextField.setTextField(placeholderText: "닉네임을 입력해주세요 :)")
        
        noticeLabel.text = ""
        noticeLabel.textColor = .primaryColor
        noticeLabel.font = .systemFont(ofSize: 13)
        noticeLabel.textAlignment = .left
        
        dividerView.backgroundColor = .systemGray4
        
        profileTabGestureView.backgroundColor = .clear
        profileTabGestureView.layer.cornerRadius = 65
    }
}
