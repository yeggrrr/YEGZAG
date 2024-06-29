//
//  ReusableProtocol+.swift
//  YEGZAG
//
//  Created by YJ on 6/13/24.
//

import UIKit

protocol ReusableProtocol: AnyObject {
    static var id: String { get }
}

extension UIView: ReusableProtocol {
    static var id: String {
        return String(describing: self)
    }
}
