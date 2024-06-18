//
//  SearchResultCollectionViewCell.swift
//  YEGZAG
//
//  Created by YJ on 6/15/24.
//

import UIKit
import SnapKit
import Kingfisher

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
        contentView.addSubview(wishButton)
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
        itemImageView.layer.cornerRadius = 10
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
        
        wishButton.backgroundColor = .lightGray
        wishButton.layer.opacity = 0.7
        wishButton.layer.cornerRadius = 10
        
        shopNameLabel.textColor = .systemGray
        shopNameLabel.font = .systemFont(ofSize: 13, weight: .regular)
        shopNameLabel.textAlignment = .left
        
        itemNameLabel.textColor = .label
        itemNameLabel.font = .systemFont(ofSize: 13, weight: .regular)
        itemNameLabel.textAlignment = .left
        itemNameLabel.numberOfLines = 2
        
        itemPriceLabel.textColor = .label
        itemPriceLabel.font = .systemFont(ofSize: 15, weight: .bold)
        itemPriceLabel.textAlignment = .left
    }
    
    func configureCell(item: Shopping.Items, inputText: String) {
        let itemImage = item.image
        let itemImageURL = URL(string: itemImage)
    
        itemImageView.kf.indicatorType = .activity
        itemImageView.kf.setImage(with: itemImageURL, options: [.transition(.fade(1)), .forceTransition])
        
        shopNameLabel.text = item.mallName
        
        let removeBTag = item.title
            .components(separatedBy: "<b>")
            .joined()
        let removeSlashBTag = removeBTag
            .components(separatedBy: "</b>")
            .joined()
        
        itemNameLabel.text = removeSlashBTag
        // Label에 있는 text 이용
        let attributedStr = NSMutableAttributedString(string: itemNameLabel.text!)
        // 원하는 스타일 적용
        attributedStr.addAttribute(.foregroundColor, value: UIColor.blue, range: (itemNameLabel.text! as NSString).range(of: inputText))
        itemNameLabel.attributedText = attributedStr
        
        if let stringToInt = Int(item.lprice) {
            itemPriceLabel.text = "\(stringToInt.formatted())원"
        }
        
        let wishList = DataStorage.fetchWishList()
        if wishList.contains(where: { $0.productId == item.productId }) {
            selectedWishButtonStyle()
        } else {
            unselectedWishButtonStyle()
        }
    }
    
    func selectedWishButtonStyle() {
        wishButton.setImage(UIImage(named: "like_selected"), for: .normal)
        wishButton.backgroundColor = .white
    }
    
    func unselectedWishButtonStyle() {
        wishButton.setImage(UIImage(named: "like_unselected"), for: .normal)
        wishButton.backgroundColor = .lightGray
    }
}
