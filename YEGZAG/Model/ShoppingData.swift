//
//  ShoppingData.swift
//  YEGZAG
//
//  Created by YJ on 6/16/24.
//

import Foundation

struct Shopping: Codable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    var items: [Items]
    
    struct Items: Codable, Hashable {
        let title: String
        let link: String
        let image: String
        let lprice: String
        let mallName: String
        let productId: String
        let brand: String
    }
}
