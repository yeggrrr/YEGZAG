//
//  DataStorage.swift
//  YEGZAG
//
//  Created by YJ on 6/14/24.
//

import Foundation
import Alamofire

struct DataStorage {
    static var userProfileImageName: String?
    static var userName: String?
    static let profileImageNameList = Array(0...11).map{ "profile_\($0)" }
    static var searchItemTitleList: [String] = []
    static var shoppingList: Shopping?
}

class APICall {
    static let shared = APICall()
    
    func searchShopData(query: String, sort: SortType, completion: @escaping(Shopping?) -> Void) {
        let url = APIURL.shoppingURL
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverID,
            "X-Naver-Client-Secret": APIKey.naverSecret
        ]
        
        let param: Parameters = [
            "query": query,
            "display": 30,
            "sort": sort.rawValue
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
