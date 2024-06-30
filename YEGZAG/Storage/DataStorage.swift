//
//  DataStorage.swift
//  YEGZAG
//
//  Created by YJ on 6/14/24.
//

import Foundation

struct DataStorage {
    static var userTempProfileImageName: String?
    
    static func save(value: Any, key: UserDefaultsUserInfo) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    static func fetchisExistUser() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsUserInfo.isExistUser.rawValue)
    }
    
    static func fetchName() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsUserInfo.name.rawValue) ?? "-"
    }
    
    static func fetchJoinDate() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsUserInfo.joinDate.rawValue) ?? "-"
    }
    
    static func fetchProfileImage() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsUserInfo.profileImage.rawValue) ?? "-"
    }
    
    static func fetchRecentSearchList() -> [String] {
        if let result = UserDefaults.standard.array(forKey: UserDefaultsUserInfo.recentSearchList.rawValue) as? [String] {
            return result
        }
        
        return []
    }
    
    static func fetchWishList() -> [Shopping.Items] {
        if let savedWishList = UserDefaults.standard.object(forKey: UserDefaultsUserInfo.wishList.rawValue) as? Data {
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode([Shopping.Items].self, from: savedWishList)
                return result
            } catch {
                print("decode error: \(error)")
            }
        }
        
        return []
    }
}
