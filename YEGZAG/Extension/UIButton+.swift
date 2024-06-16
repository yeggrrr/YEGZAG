//
//  UIButton+.swift
//  YEGZAG
//
//  Created by YJ on 6/16/24.
//

import UIKit

extension UIButton {
    func setUI(title: String,  bgColor: UIColor, textColor: UIColor) {
        setTitleColor(textColor, for: .normal)
        backgroundColor = bgColor
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        layer.cornerRadius = 18
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
}
