//
//  NoticeLabel.swift
//  YEGZAG
//
//  Created by YJ on 6/13/24.
//

import UIKit

class NoticeLabel: UILabel {
    
    init(txt: String, txtColor: UIColor) {
        super.init(frame: .zero)
        
        text = txt
        textColor = txtColor
        font = .systemFont(ofSize: 13)
        textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
