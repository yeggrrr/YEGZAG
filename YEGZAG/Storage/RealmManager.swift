//
//  RealmManager.swift
//  YEGZAG
//
//  Created by YJ on 7/7/24.
//

import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    private let realm = try! Realm()
    
    func findFilePath() {
        print(realm.configuration.fileURL ?? "-")
    }
    
    func fetch() -> [ItemRealm] {
        return Array(realm.objects(ItemRealm.self))
    }
    
    func add(item: ItemRealm) {
        try! realm.write {
            realm.add(item)
        }
    }
    
    func update(item: ItemRealm) {
        try! realm.write {
            realm.add(item, update: .modified)
        }
    }
    
    func delete(item: ItemRealm) {
        try! realm.write {
            realm.delete(item)
        }
    }
}
