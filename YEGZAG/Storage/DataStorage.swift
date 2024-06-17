//
//  DataStorage.swift
//  YEGZAG
//
//  Created by YJ on 6/14/24.
//

import Foundation
import Alamofire

struct DataStorage {
    static var userTempProfileImageName: String? // 프로필 수정 화면에서 사용
    static let profileImageNameList = Array(0...11).map{ "profile_\($0)" }
    static var shoppingList: Shopping?
    
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

class APICall {
    static let shared = APICall()
    
    func searchShopData(query: String, sort: SortType, start: Int, completion: @escaping(Shopping?) -> Void) {
        let url = APIURL.shoppingURL
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverID,
            "X-Naver-Client-Secret": APIKey.naverSecret
        ]
        
        let param: Parameters = [
            "query": query,
            "display": 30,
            "sort": sort.rawValue,
            "start": start
        ]
        
        AF.request(url, method: .get, parameters: param, headers: header).responseDecodable(of: Shopping.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                completion(nil)
                print(error)
            }
        }
    }
}
