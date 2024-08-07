//
//  MainViewController.swift
//  YEGZAG
//
//  Created by YJ on 6/14/24.
//

import UIKit
import SnapKit

enum SortType: String {
    case sim
    case date
    case asc
    case dsc
}

final class MainViewController: UIViewController {
    private let searchBar = UISearchBar()
    private let noneRecentSearchImageView = UIImageView()
    private let noneRecentSearchLabel = UILabel()
    
    private let searchListView = UIView()
    private let topLabelView = UIView()
    private let recentSearchLabel = UILabel()
    private let removeAllButton = UIButton()
    private let searchListTableView = UITableView()
    
    private var shoppingList: Shopping?
    
    private var start = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFolder()
        configureView()
        configureHierarchy()
        configureLayout()
        configureUI()
        congfigureSearchBar()
        configureTableView()
        RealmManager.shared.findFilePath()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let recentSearchList = DataStorage.fetchRecentSearchList()
        
        let isSearchListEmpty = recentSearchList.isEmpty
        searchListView.isHidden = isSearchListEmpty
        
        setNickname()
        searchListTableView.reloadData()
    }
    
    private func configureView() {
        // view
        view.backgroundColor = .white
        // naviation
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        setNickname()
    }
    
    private func configureTableView() {
        searchListTableView.delegate = self
        searchListTableView.dataSource = self
        searchListTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        searchListTableView.separatorStyle = .none
    }
    
    private func congfigureSearchBar() {
        searchBar.delegate = self
    }
    
    private func configureHierarchy() {
        // emptyHierarchy
        view.addSubview(searchBar)
        view.addSubview(noneRecentSearchImageView)
        view.addSubview(noneRecentSearchLabel)
        
        view.addSubview(searchListView)
        searchListView.addSubview(topLabelView)
        topLabelView.addSubview(recentSearchLabel)
        topLabelView.addSubview(removeAllButton)
        
        searchListView.addSubview(searchListTableView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        // emptyLayout
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeArea)
        }
        
        noneRecentSearchImageView.snp.makeConstraints {
            $0.center.equalTo(safeArea.snp.center)
        }
        
        noneRecentSearchLabel.snp.makeConstraints {
            $0.top.equalTo(noneRecentSearchImageView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(safeArea)
        }
        
        searchListView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeArea)
        }
        
        topLabelView.snp.makeConstraints {
            $0.top.equalTo(searchListView)
            $0.horizontalEdges.equalTo(searchListView)
            $0.height.equalTo(44)
        }
        
        recentSearchLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(topLabelView)
            $0.leading.equalTo(topLabelView.snp.leading).offset(10)
        }
        
        removeAllButton.snp.makeConstraints {
            $0.top.bottom.equalTo(topLabelView)
            $0.trailing.equalTo(topLabelView.snp.trailing).offset(-10)
        }
        
        searchListTableView.snp.makeConstraints {
            $0.top.equalTo(topLabelView.snp.bottom)
            $0.horizontalEdges.equalTo(searchListView)
            $0.bottom.equalTo(searchListView)
        }
    }
    
    private func configureUI() {
        // emptyUI
        searchBar.placeholder = "브랜드, 상품 등을 입력하세요."
        noneRecentSearchImageView.image = UIImage(named: "empty")
        
        noneRecentSearchLabel.setUI(labelText: "최근 검색어가 없어요", txtColor: .label, fontStyle: .systemFont(ofSize: 20, weight: .black), txtAlignment: .center)
        recentSearchLabel.setUI(labelText: "최근 검색", txtColor: .label, fontStyle: .systemFont(ofSize: 17, weight: .black), txtAlignment: .left)
        removeAllButton.setTitle("전체 삭제", for: .normal)
        removeAllButton.setTitleColor(UIColor.primaryColor, for: .normal)
        removeAllButton.addTarget(self, action: #selector(removeAllButtonClicked), for: .touchUpInside)
    }
    
    private func setFolder() {
        let folderList: [FolderType] = [.jim, .clothes, .interier, .cosmetics]
        let categories: [Folder] = folderList.map { Folder(name: $0.rawValue) }

        if RealmManager.shared.fetchFolder().isEmpty {
            categories.forEach { folder in
                RealmManager.shared.addFolder(item: folder)
            }
        }
    }
    
    private func setNickname() {
        let userName = DataStorage.fetchName()
        navigationItem.title = "\(userName)'s YEGZAG"
    }
    
    @objc func removeAllButtonClicked() {
        DataStorage.save(value: [], key: .recentSearchList)
        searchListTableView.reloadData()
        searchListView.isHidden = true
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStorage.fetchRecentSearchList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        let itemList = DataStorage.fetchRecentSearchList()
        cell.deleteButton.tag = indexPath.row
        cell.selectionStyle = .none
        cell.itemLabel.text = itemList.reversed()[indexPath.row]
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonClicked(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let clickedValue = DataStorage.fetchRecentSearchList().reversed()[indexPath.row]
        let recentSearchList = DataStorage.fetchRecentSearchList()
        var newRecentSearchList = recentSearchList
        
        for (index, keyword) in newRecentSearchList.enumerated() {
            if keyword == clickedValue {
                newRecentSearchList.remove(at: index)
            }
        }
        
        newRecentSearchList.append(clickedValue)
        DataStorage.save(value: newRecentSearchList, key: .recentSearchList)
        
        APICall.shared.callRequest(query: clickedValue, sort: .sim, start: start, model: Shopping.self) { shopping, error in
            guard let shopping = shopping else { return }
            self.shoppingList = shopping
            
            self.searchListView.isHidden = false
            
            if self.shoppingList?.items.count != 0 {
                let searchResultVC  = SearchResultViewController()
                searchResultVC.searchText = clickedValue
                searchResultVC.shoppingList = shopping
                self.navigationController?.pushViewController(searchResultVC, animated: true)
            }
            
            self.searchListTableView.reloadData()
        }
    }
    
    @objc func deleteButtonClicked(_ sender: UIButton) {
        let index = sender.tag
        let recentSearchList = DataStorage.fetchRecentSearchList()
        var newRecentSearchList = recentSearchList
        newRecentSearchList.remove(at: recentSearchList.count - index - 1)
        DataStorage.save(value: newRecentSearchList, key: .recentSearchList)
        
        if newRecentSearchList.isEmpty {
            searchListView.isHidden = true
        }
        
        searchListTableView.reloadData()
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        let recentSearchList = DataStorage.fetchRecentSearchList()
        var newRecentSearchList = recentSearchList
        
        for (index, keyword) in newRecentSearchList.enumerated() {
            if keyword == text {
                newRecentSearchList.remove(at: index)
            }
        }
        
        newRecentSearchList.append(text)
        DataStorage.save(value: newRecentSearchList, key: .recentSearchList)
        
        APICall.shared.callRequest(query: text, sort: .sim, start: start, model: Shopping.self) { shopping, error in
            guard let shopping = shopping else { return }
            self.shoppingList = shopping
            
            let isSearchListEmpty = newRecentSearchList.isEmpty
            self.searchListView.isHidden = isSearchListEmpty
            
            if !shopping.items.isEmpty || text.isEmpty {
                searchBar.text = ""
                let searchResultVC  = SearchResultViewController()
                searchResultVC.searchText = text
                searchResultVC.shoppingList = self.shoppingList
                self.navigationController?.pushViewController(searchResultVC, animated: true)
            }
            
            self.searchListTableView.reloadData()
        }
    }
}
