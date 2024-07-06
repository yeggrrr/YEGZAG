//
//  WishCollectionViewCell.swift
//  YEGZAG
//
//  Created by YJ on 7/6/24.
//

import UIKit

class WishCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
