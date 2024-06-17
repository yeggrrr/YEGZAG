//
//  SelectImageCollectionViewCell.swift
//  YEGZAG
//
//  Created by YJ on 6/13/24.
//

import UIKit
import SnapKit

class SelectImageCollectionViewCell: UICollectionViewCell {
    let profileImageView  = UIImageView()
    let profileBorderView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureUI()
    }
    
    override func layoutSubviews() {
      super.layoutSubviews()
        
        profileBorderView.layoutIfNeeded()
        profileBorderView.layer.cornerRadius = profileBorderView.frame.width / 2
        profileBorderView.clipsToBounds = true
    }
    
    func configureUI() {
        contentView.addSubview(profileBorderView)
        profileBorderView.addSubview(profileImageView)
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        profileBorderView.snp.makeConstraints {
            $0.edges.equalTo(safeArea).inset(5)
        }
        
        profileImageView.snp.makeConstraints {
            $0.edges.equalTo(profileBorderView).inset(10)
        }
    
        profileBorderView.layer.borderWidth = 1
        profileBorderView.layer.borderColor = UIColor.darkGray.cgColor
        
        profileImageView.image = UIImage(named: "profile_0")
        profileImageView.contentMode = .scaleAspectFill
    }
    
    func configureImage(imageName: String?) {
        var selectedImageName = ""
        
        if let userTempProfileImageName = DataStorage.userTempProfileImageName {
            selectedImageName = userTempProfileImageName
        } else {
            selectedImageName = DataStorage.fetchProfileImage()
        }
        
        if imageName == selectedImageName {
            contentView.layer.opacity = 1
            profileBorderView.layer.borderColor = UIColor.systemPink.cgColor
            profileBorderView.layer.borderWidth = 3
        } else {
            contentView.layer.opacity = 0.5
            profileBorderView.layer.borderColor = UIColor.black.cgColor
            profileBorderView.layer.borderWidth = 1
        }
    }
}
