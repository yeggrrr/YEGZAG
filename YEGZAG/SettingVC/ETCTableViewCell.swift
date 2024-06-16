//
//  ETCTableViewCell.swift
//  YEGZAG
//
//  Created by YJ on 6/16/24.
//

import UIKit
import SnapKit

class ETCTableViewCell: UITableViewCell {
    let wishListLabel = UILabel()
    let wishStackView = UIStackView()
    let bagImageView = UIImageView()
    let wishCountLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureHierarchy() {
        contentView.addSubview(wishListLabel)
        contentView.addSubview(wishStackView)
        wishStackView.addArrangedSubview(bagImageView)
        wishStackView.addArrangedSubview(wishCountLabel)
    }
    
    func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        wishListLabel.snp.makeConstraints {
            $0.leading.equalTo(safeArea).offset(15)
            $0.centerY.equalTo(safeArea.snp.centerY)
            $0.trailing.greaterThanOrEqualTo(wishStackView.snp.leading).offset(-20)
        }
        
        wishStackView.snp.makeConstraints {
            $0.trailing.equalTo(safeArea).offset(-15)
            $0.centerY.equalTo(safeArea.snp.centerY)
        }
        
        bagImageView.snp.makeConstraints {
            $0.height.width.equalTo(17)
        }
        
        wishCountLabel.snp.makeConstraints {
            $0.height.equalTo(17)
        }
    }
    
    func configureUI() {
        wishListLabel.text = "나의 장바구니 목록"
        wishListLabel.textColor = .label
        wishListLabel.textAlignment = .left
        wishListLabel.font = .systemFont(ofSize: 16, weight: .regular)
        
        wishStackView.axis = .horizontal
        wishStackView.spacing = 5
        wishStackView.alignment = .fill
        wishStackView.distribution = .fill
        // wishStackView.isHidden = true
        
        bagImageView.image = UIImage(named: "like_selected")
        bagImageView.tintColor = .black
        
        wishCountLabel.text = "18개의 상품"
        wishCountLabel.textColor = .label
        wishCountLabel.textAlignment = .left
        wishCountLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    }
}
