//
//  DataStorage.swift
//  YEGZAG
//
//  Created by YJ on 6/14/24.
//

import Foundation

struct DataStorage {
    static var userProfileImageName: String?
    static var userName: String?
    static let profileImageNameList = Array(0...11).map{ "profile_\($0)" }
}
