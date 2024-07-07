//
//  ShoppingData.swift
//  YEGZAG
//
//  Created by YJ on 6/16/24.
//

import Foundation
import RealmSwift

struct Shopping: Decodable {
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


class ItemRealm: Object {
    @Persisted(primaryKey: true) var productId: String
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var image: String
    @Persisted var lprice: String
    @Persisted var mallName: String
    @Persisted var brand: String
    @Persisted var isLike: Bool
    
    convenience init(productId: String, title: String, link: String, image: String, lprice: String, mallName: String, brand: String, isLike: Bool = true) {
        self.init()
        self.productId = productId
        self.title = title
        self.link = link
        self.image = image
        self.lprice = lprice
        self.mallName = mallName
        self.brand = brand
        self.isLike = isLike
    }
}
