//
//  UIButton+.swift
//  YEGZAG
//
//  Created by YJ on 6/16/24.
//

import UIKit

extension UIButton {
    func setUI(title: String, bgColor: UIColor, textColor: UIColor) {
        setTitle(title, for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        backgroundColor = bgColor
        layer.cornerRadius = 18
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
}
