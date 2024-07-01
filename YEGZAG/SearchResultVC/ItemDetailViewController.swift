//
//  ItemDetailViewController.swift
//  YEGZAG
//
//  Created by YJ on 6/15/24.
//

import UIKit
import SnapKit
import WebKit

final class ItemDetailViewController: UIViewController {
    private let webView = WKWebView()
    var index: Int?
    var searchText: String?
    var item: Shopping.Items?
    var shoppingList: Shopping?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureWebView()
    }
    
    private func configureUI() {
        // view
        view.backgroundColor = .white
        // navigation
        guard let index = index else { return }
        if let item = shoppingList?.items[index] {
            let removeBTag = item.title
                .components(separatedBy: "<b>")
                .joined()
            let removeSlashBTag = removeBTag
                .components(separatedBy: "</b>")
                .joined()
            
            navigationItem.title = removeSlashBTag
        }
        
        navigationItem.rightBarButtonItem?.tintColor = .black
        updateWishButtonState()
    }
    
    private func configureWebView() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        guard let index = index else { return }
        guard let items = shoppingList?.items else { return }
        let detailLink = items[index].link
        guard let detailURL = URL(string: detailLink) else { return }
        let request = URLRequest(url: detailURL)
        webView.load(request)
    }
    
    private func updateWishButtonState() {
        guard let item = item else { return }
        
        let wishList = DataStorage.fetchWishList()
        if wishList.contains(where: { $0.productId == item.productId }) {
            let rightWishButtonItem = UIBarButtonItem(image: UIImage(named: "like_selected"), style: .plain, target: self, action: #selector(rightWishButtonClicked))
            navigationItem.rightBarButtonItem = rightWishButtonItem
        } else {
            let rightWishButtonItem = UIBarButtonItem(image: UIImage(named: "like_unselected"), style: .plain, target: self, action: #selector(rightWishButtonClicked))
            navigationItem.rightBarButtonItem = rightWishButtonItem
        }
    }
    
    @objc func rightWishButtonClicked() {
        guard let item = item else { return }
        let wishList = DataStorage.fetchWishList()
        var newWishList = wishList
        
        if wishList.contains(item) {
            newWishList = wishList.filter{ $0.productId != item.productId }
        } else {
            newWishList.append(item)
        }
        
        do {
            let encoder = JSONEncoder()
            let result = try encoder.encode(newWishList)
            DataStorage.save(value: result, key: .wishList)
        } catch {
            showAlert(title: "Error!!", message: "정보를 업데이트 하는데 실패했습니다. 다시 시도해주세요.") { _ in
                print("encoding error: \(error)")
            }
        }
        
        updateWishButtonState()
    }
}
