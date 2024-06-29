//
//  UIViewController+.swift
//  YEGZAG
//
//  Created by YJ on 6/27/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, completionHandler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: completionHandler)
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
}
