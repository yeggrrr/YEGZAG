//
//  ItemDetailViewController.swift
//  YEGZAG
//
//  Created by YJ on 6/15/24.
//

import UIKit
import SnapKit
import WebKit

class ItemDetailViewController: UIViewController {
    let webView = WKWebView()
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureWebView()
    }
    
    func configureUI() {
        // view
        view.backgroundColor = .white
        // navigation
        navigationItem.title = "상품 이름"
        let rightWishButtonItem = UIBarButtonItem(image: UIImage(named: "like_unselected"), style: .plain, target: self, action: #selector(rightWishButtonClicked))
        navigationItem.rightBarButtonItem = rightWishButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    func configureWebView() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        guard let index = index else { return }
        let detailLink = DataStorage.searchItemList[index].link
        guard let detailURL = URL(string: detailLink) else { return }
        let request = URLRequest(url: detailURL)
        webView.load(request)
    }
    
    @objc func rightWishButtonClicked() {
        
    }
}
