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
    
    func addItem(_ object: ItemRealm, folder: Folder) {
        do {
            try realm.write {
                folder.detail.append(object)
                realm.add(object)
            }
        } catch {
            print(error, "Realm Create Succeed")
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

extension RealmManager {
    func fetchFolder() -> [Folder] {
        let objects = realm.objects(Folder.self)
        return Array(objects)
    }
    
    func addFolder(item: Folder) {
        try! realm.write {
            realm.add(item)
        }
    }
    
    func removeFolder(_ folder: Folder) {
        do {
            try realm.write {
                realm.delete(folder.detail)
                realm.delete(folder)
            }
        } catch {
            print(error, "Folder Remove Failed")
        }
    }
}
