//
//  ItemDetailViewController.swift
//  YEGZAG
//
//  Created by YJ on 6/15/24.
//

import UIKit

class ItemDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "상품 이름"
        let rightWishButtonItem = UIBarButtonItem(image: UIImage(named: "like_selected"), style: .plain, target: self, action: #selector(rightWishButtonClicked))
        navigationItem.rightBarButtonItem = rightWishButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func rightWishButtonClicked() {
        
    }
}
