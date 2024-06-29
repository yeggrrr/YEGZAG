//
//  APIManager.swift
//  YEGZAG
//
//  Created by YJ on 6/29/24.
//

import UIKit
import Alamofire

class APICall {
    static let shared = APICall()
    
    private init() { }
    
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
