//
//  SearchResultCollectionViewCell.swift
//  YEGZAG
//
//  Created by YJ on 6/15/24.
//

import UIKit
import SnapKit

class SearchResultCollectionViewCell: UICollectionViewCell {
    let itemImageView = UIImageView()
    let wishButton = UIButton()
    let shopNameLabel = UILabel()
    let itemNameLabel = UILabel()
    let itemPriceLabel = UILabel()
    
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
        contentView.addSubview(itemImageView)
        itemImageView.addSubview(wishButton)
        contentView.addSubview(shopNameLabel)
        contentView.addSubview(itemNameLabel)
        contentView.addSubview(itemPriceLabel)
    }
    
    func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        let cellHeigth = contentView.frame.height
        itemImageView.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(5)
            $0.horizontalEdges.equalTo(safeArea).inset(5)
            $0.height.equalTo(cellHeigth - 80)
        }
        
        wishButton.snp.makeConstraints {
            $0.trailing.equalTo(itemImageView.snp.trailing).offset(-10)
            $0.bottom.equalTo(itemImageView.snp.bottom).offset(-10)
            $0.height.width.equalTo(cellHeigth - (cellHeigth - 30))
        }
        
        shopNameLabel.snp.makeConstraints {
            $0.top.equalTo(itemImageView.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea).inset(5)
            $0.height.equalTo(20)
        }
        
        itemNameLabel.snp.makeConstraints {
            $0.top.equalTo(shopNameLabel.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea).inset(5)
        }
        
        itemPriceLabel.snp.makeConstraints {
            $0.top.equalTo(itemNameLabel.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea).inset(5)
            $0.bottom.greaterThanOrEqualTo(safeArea).offset(-5)
        }
    }
    
    func configureUI() {
        itemImageView.backgroundColor = .systemGray4
        itemImageView.layer.cornerRadius = 10
        
        wishButton.backgroundColor = .systemGray2
        wishButton.setImage(UIImage(named: "like_unselected"), for: .normal)
        wishButton.backgroundColor = .lightGray
        wishButton.layer.opacity = 0.5
        wishButton.layer.cornerRadius = 10
        
        shopNameLabel.text = "네이버"
        shopNameLabel.textColor = .systemGray2
        shopNameLabel.font = .systemFont(ofSize: 13, weight: .regular)
        shopNameLabel.textAlignment = .left
        
        itemNameLabel.text = "애플 레트로 키캡 XDA PBT 한무무 기계식 키보드"
        itemNameLabel.textColor = .label
        itemNameLabel.font = .systemFont(ofSize: 13, weight: .regular)
        itemNameLabel.textAlignment = .left
        itemNameLabel.numberOfLines = 2
        
        itemPriceLabel.text = "22,800원"
        itemPriceLabel.textColor = .label
        itemPriceLabel.font = .systemFont(ofSize: 15, weight: .bold)
        itemPriceLabel.textAlignment = .left
    }
}
