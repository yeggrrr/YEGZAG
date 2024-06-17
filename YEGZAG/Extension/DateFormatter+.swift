//
//  DateFormatter+.swift
//  YEGZAG
//
//  Created by YJ on 6/16/24.
//

import Foundation

extension DateFormatter {
    static var dotDateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter
    }()
}
