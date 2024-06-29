//
//  PointButton.swift
//  YEGZAG
//
//  Created by YJ on 6/13/24.

import UIKit

class PointButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 17, weight: .heavy)
        backgroundColor = .primaryColor
        layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
