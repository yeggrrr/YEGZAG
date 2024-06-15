//
//  FilterButton.swift
//  YEGZAG
//
//  Created by YJ on 6/15/24.
//

import UIKit

class FilterButton: UIButton {
    init(title: String, bgColor: UIColor, textColor: UIColor) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        backgroundColor = bgColor
        layer.cornerRadius = 18
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
