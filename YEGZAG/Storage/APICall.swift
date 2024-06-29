//
//  APIManager.swift
//  YEGZAG
//
//  Created by YJ on 6/29/24.
//

import UIKit

enum YegrError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

class APICall {
    static let shared = APICall()
    
    private init() { }
    
    func callRequest<T: Decodable>(query: String, sort: SortType, start: Int, model: T.Type,completion: @escaping(T?, YegrError?) -> Void) {
        var component = URLComponents()
        component.scheme = Component.scheme
        component.host = Component.host
        component.path = Component.path
        component.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "display", value: "30"),
            URLQueryItem(name: "sort", value: sort.rawValue),
            URLQueryItem(name: "start", value: String(start))
        ]
        
        guard let componentURL = component.url else {
            print("componentURL Error")
            return
        }
        
        var urlRequest = URLRequest(url: componentURL)
        urlRequest.allHTTPHeaderFields = [
            "X-Naver-Client-Id": APIKey.naverID,
            "X-Naver-Client-Secret": APIKey.naverSecret
        ]
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No Data Returned")
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    print("Unable Response")
                    return
                }
                
                guard response.statusCode == 200 else {
                    completion(nil, .invalidData)
                    print("Failed Response")
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let result = try decoder.decode(T.self, from: data)
                    print("SUCCESS")
                    completion(result, nil)
                } catch {
                    print(error)
                }
            }
        }
        .resume()
    }
}
