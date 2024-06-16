//
//  DateFormatter+.swift
//  YEGZAG
//
//  Created by YJ on 6/16/24.
//

import Foundation

extension DateFormatter {
    static var dashDateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    static var dotDateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter
    }()
    
    static func dashToDot(dateString: String) -> String {
        if let date = dashDateFormatter.date(from: dateString) {
            let dotDateString = dotDateFormatter.string(from: date)
            return dotDateString
        }
        return "-"
    }
}
