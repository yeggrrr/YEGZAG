//
//  SelectedListTableViewCell.swift
//  YEGZAG
//
//  Created by YJ on 7/8/24.
//

import UIKit
import SnapKit

class SelectedListTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let countLabel = UILabel()
    
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
    }
    
    func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(safeArea).offset(20)
            $0.verticalEdges.equalTo(safeArea).inset(10)
        }
        
        countLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(5)
            $0.verticalEdges.equalTo(safeArea).inset(10)
        }
    }
    
    func configureUI() {
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .left
        
        countLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        countLabel.textColor = .darkGray
        titleLabel.textAlignment = .left
    }
}
