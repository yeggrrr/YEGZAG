//
//  RandomImage.swift
//  YEGZAG
//
//  Created by YJ on 6/13/24.
//

import UIKit

extension UIImage {
    static func random() -> String {
        let profileImageList: [String] = ["profile_0", "profile_1", "profile_2", "profile_3", "profile_4", "profile_5", "profile_6", "profile_7", "profile_8", "profile_9", "profile_10", "profile_11"]
        guard let randomProfile = profileImageList.randomElement() else { return "-" }
        return randomProfile
    }
}
