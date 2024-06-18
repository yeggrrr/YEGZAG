//
//  UILabel+.swift
//  YEGZAG
//
//  Created by YJ on 6/18/24.
//

import UIKit

extension UILabel {
    func setUI(labelText: String, txtColor: UIColor, fontStyle: UIFont, txtAlignment: NSTextAlignment) {
        text = labelText
        textColor = txtColor
        font = fontStyle
        textAlignment = txtAlignment
    }
}
