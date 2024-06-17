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
    var searchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureWebView()
    }
    
    func configureUI() {
        // view
        view.backgroundColor = .white
        // navigation
        guard let index = index else { return }
        if let item = DataStorage.shoppingList?.items[index] {
            let removeBTag = item.title
                .components(separatedBy: "<b>")
                .joined()
            let removeSlashBTag = removeBTag
                .components(separatedBy: "</b>")
                .joined()
            
            navigationItem.title = removeSlashBTag
        }
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
        guard let items = DataStorage.shoppingList?.items else { return }
        let detailLink = items[index].link
        guard let detailURL = URL(string: detailLink) else { return }
        let request = URLRequest(url: detailURL)
        webView.load(request)
    }
    
    @objc func rightWishButtonClicked() {
        
    }
}
