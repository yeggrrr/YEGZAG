//
//  SearchTableViewCell.swift
//  YEGZAG
//
//  Created by YJ on 6/14/24.
//

import UIKit
import SnapKit

class SearchTableViewCell: UITableViewCell {
    let clockImageView = UIImageView()
    let itemLabel = UILabel()
    let deleteButton = UIButton()
    
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
        contentView.addSubview(clockImageView)
        contentView.addSubview(itemLabel)
        contentView.addSubview(deleteButton)
    }
    
    func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        clockImageView.snp.makeConstraints {
            $0.top.bottom.equalTo(safeArea).inset(10)
            $0.leading.equalTo(safeArea).offset(10)
            $0.width.equalTo(clockImageView.snp.height)
        }
        
        itemLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(safeArea)
            $0.leading.equalTo(clockImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(deleteButton.snp.leading).offset(-10)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.bottom.equalTo(safeArea)
            $0.trailing.equalTo(safeArea)
            $0.width.equalTo(deleteButton.snp.height)
        }
    }
    
    func configureUI() {
        clockImageView.image = UIImage(systemName: "clock")
        clockImageView.tintColor = .black
        clockImageView.contentMode = .scaleAspectFit
        
        itemLabel.textColor = .label
        itemLabel.textAlignment = .left
        itemLabel.font = .systemFont(ofSize: 15, weight: .regular)
        
        deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        deleteButton.tintColor = .black
    }
}
