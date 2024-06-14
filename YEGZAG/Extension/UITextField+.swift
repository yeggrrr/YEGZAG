//
//  UITextField+.swift
//  YEGZAG
//
//  Created by YJ on 6/13/24.
//

import UIKit

extension UITextField {
    func setTextField(placeholderText: String) {
        placeholder = placeholderText
        borderStyle = .none
        textAlignment = .left
        tintColor = .darkGray
        leftPadding()
    }
    
    func leftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
