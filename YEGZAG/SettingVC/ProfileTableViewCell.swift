//
//  ProfileTableViewCell.swift
//  YEGZAG
//
//  Created by YJ on 6/16/24.
//

import UIKit
import SnapKit

final class ProfileTableViewCell: UITableViewCell {
    let profileImageView = UIImageView()
    private let nameDateStackView = UIStackView()
    let userNameLabel = UILabel()
    let joinDateLagel = UILabel()
    private let rightButtonImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        profileImageView.layoutIfNeeded() // animation
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
    }
    
    private func configureHierarchy() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameDateStackView)
        nameDateStackView.addArrangedSubview(userNameLabel)
        nameDateStackView.addArrangedSubview(joinDateLagel)
        contentView.addSubview(rightButtonImageView)
    }
    
    private func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        profileImageView.snp.makeConstraints {
            $0.leading.equalTo(safeArea).offset(15)
            $0.top.bottom.equalTo(safeArea).inset(20)
            $0.width.equalTo(profileImageView.snp.height)
        }
        
        nameDateStackView.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
            $0.centerY.equalTo(safeArea.snp.centerY)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        joinDateLagel.snp.makeConstraints {
            $0.height.equalTo(15)
        }
        
        rightButtonImageView.snp.makeConstraints {
            $0.trailing.equalTo(safeArea).offset(-15)
            $0.centerY.equalTo(safeArea.snp.centerY)
            $0.width.equalTo(20)
            $0.height.equalTo(25)
        }
    }
    
    private func configureUI() {
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor.primaryColor.cgColor
        
        nameDateStackView.axis = .vertical
        nameDateStackView.spacing = 10
        nameDateStackView.alignment = .fill
        nameDateStackView.distribution = .fillProportionally
        
        userNameLabel.textColor = .label
        userNameLabel.textAlignment = .left
        userNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        joinDateLagel.textColor = .lightGray
        joinDateLagel.textAlignment = .left
        joinDateLagel.font = .systemFont(ofSize: 17, weight: .regular)
        
        rightButtonImageView.image = UIImage(systemName: "chevron.right")
        rightButtonImageView.tintColor = .darkGray
    }
}
