//
//  MainViewController.swift
//  YEGZAG
//
//  Created by YJ on 6/14/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    let searchBar = UISearchBar()
    let noneRecentSearchImageView = UIImageView()
    let noneRecentSearchLabel = UILabel()
    
    let searchListView = UIView()
    let topLabelView = UIView()
    let recentSearchLabel = UILabel()
    let removeAllButton = UIButton()
    let searchListTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureHierarchy()
        configureLayout()
        configureUI()
        congfigureSearchBar()
        configureTableView()
        // searchListView.isHidden = true
    }
    
    func configureView() {
        // view
        view.backgroundColor = .white
        // naviation
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        guard let userName = DataStorage.userName else { return }
        navigationItem.title = "\(userName)'s YEGZAG"
    }
    
    func configureTableView() {
        searchListTableView.delegate = self
        searchListTableView.dataSource = self
        searchListTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        searchListTableView.separatorStyle = .none
    }
    
    func congfigureSearchBar() {
        searchBar.delegate = self
    }
    
    func configureHierarchy() {
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
    
    func configureLayout() {
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
    
    func configureUI() {
        // emptyUI
        searchBar.placeholder = "브랜드, 상품 등을 입력하세요."
        noneRecentSearchImageView.image = UIImage(named: "empty")
        noneRecentSearchLabel.text = "최근 검색어가 없어요"
        noneRecentSearchLabel.textColor = .label
        noneRecentSearchLabel.font = .systemFont(ofSize: 20, weight: .black)
        noneRecentSearchLabel.textAlignment = .center
        // searchListUI
        recentSearchLabel.text = "최근 검색"
        recentSearchLabel.font = .systemFont(ofSize: 17, weight: .bold)
        removeAllButton.setTitle("전체 삭제", for: .normal)
        removeAllButton.setTitleColor(UIColor.systemPink, for: .normal)
        
        removeAllButton.addTarget(self, action: #selector(removeAllButtonClicked), for: .touchUpInside)
    }
    
    @objc func removeAllButtonClicked() {
        DataStorage.searchItemList.removeAll()
        searchListTableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStorage.searchItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        let itemList = DataStorage.searchItemList
        cell.deleteButton.tag = indexPath.row
        cell.selectionStyle = .none
        cell.itemLabel.text = itemList.reversed()[indexPath.row]
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonClicked(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func deleteButtonClicked(_ sender: UIButton) {
        let index = sender.tag
        print(DataStorage.searchItemList, DataStorage.searchItemList.count - index)
        DataStorage.searchItemList.remove(at: DataStorage.searchItemList.count - index - 1)
        searchListTableView.reloadData()
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        guard let text = searchBar.text else { return }
        DataStorage.searchItemList.append(text)
        searchListTableView.reloadData()
        searchBar.text = ""
        
        let searchResultVC = SearchResultViewController()
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
}
