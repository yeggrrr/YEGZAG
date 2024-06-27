//
//  SearchResultViewController.swift
//  YEGZAG
//
//  Created by YJ on 6/15/24.
//

import UIKit
import SnapKit

class SearchResultViewController: UIViewController {
    let topElementView = UIView()
    let entireResultCountLabel = UILabel()
    let filterButtonStackView = UIStackView()
    let accuracyButton = UIButton()
    let dateButton = UIButton()
    let highestPriceButton = UIButton()
    let lowestPriceButton = UIButton()
    
    let resultCollecionView = UICollectionView(frame: .zero, collectionViewLayout: CollecionViewLayout())
    var searchText: String?
    
    var isLoading: Bool = false
    var start = 1
    let maxStartValue = 1000
    var sortType: SortType = .sim {
        didSet {
            sortData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureCollecionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resultCollecionView.reloadData()
    }
    
    func configureView() {
        // view
        view.backgroundColor = .white
        // navigation
        navigationItem.title = searchText
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    func configureCollecionView() {
        resultCollecionView.delegate = self
        resultCollecionView.dataSource = self
        resultCollecionView.prefetchDataSource = self
        resultCollecionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
    }
    
    func configureHierarchy() {
        view.addSubview(topElementView)
        topElementView.addSubview(entireResultCountLabel)
        topElementView.addSubview(filterButtonStackView)
        filterButtonStackView.addArrangedSubview(accuracyButton)
        filterButtonStackView.addArrangedSubview(dateButton)
        filterButtonStackView.addArrangedSubview(highestPriceButton)
        filterButtonStackView.addArrangedSubview(lowestPriceButton)
        
        view.addSubview(resultCollecionView)
    }
    
    func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        topElementView.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(80)
        }
        
        entireResultCountLabel.snp.makeConstraints {
            $0.top.equalTo(topElementView)
            $0.horizontalEdges.equalTo(topElementView).inset(20)
            $0.height.equalTo(35)
        }
        
        filterButtonStackView.snp.makeConstraints {
            $0.top.equalTo(entireResultCountLabel.snp.bottom)
            $0.leading.equalTo(topElementView.snp.leading).offset(20)
            $0.bottom.equalTo(topElementView.snp.bottom).offset(-10)
        }
        
        [accuracyButton, dateButton, highestPriceButton, lowestPriceButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(filterButtonStackView)
            }
        }
        
        resultCollecionView.snp.makeConstraints {
            $0.top.equalTo(topElementView.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea)
            $0.bottom.equalTo(safeArea)
        }
    }
    
    func configureUI() {
        let resultCount = DataStorage.shoppingList?.total ?? 0
        entireResultCountLabel.setUI(labelText: "\(resultCount.formatted())개의 검색 결과", txtColor: .systemPink, fontStyle: .systemFont(ofSize: 16, weight: .bold), txtAlignment: .left)
        
        filterButtonStackView.axis = .horizontal
        filterButtonStackView.spacing = 10
        filterButtonStackView.alignment = .leading
        filterButtonStackView.distribution = .fillProportionally
        
        accuracyButton.addTarget(self, action: #selector(accuracyButtonClicked), for: .touchUpInside)
        dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        highestPriceButton.addTarget(self, action: #selector(highestButtonClicked), for: .touchUpInside)
        lowestPriceButton.addTarget(self, action: #selector(lowestButtonClicked), for: .touchUpInside)
        
        configureFilterButtonUI()
    }
    
    static func CollecionViewLayout() -> UICollectionViewLayout {
        let layout  = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 20
        let cellSpacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 2) + 20
        layout.itemSize = CGSize(width: width / 2, height: width / 1.3)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    func configureFilterButtonUI() {
        switch sortType {
        case .sim:
            accuracyButton.setUI(title: "  정확도  ", bgColor: .darkGray, textColor: .white)
            dateButton.setUI(title: "  날짜순  ", bgColor: .white, textColor: .label)
            highestPriceButton.setUI(title: "  가격높은순  ", bgColor: .white, textColor: .label)
            lowestPriceButton.setUI(title: "  가격낮은순  ", bgColor: .white, textColor: .label)
        case .date:
            accuracyButton.setUI(title: "  정확도  ", bgColor: .white, textColor: .label)
            dateButton.setUI(title: "  날짜순  ", bgColor: .darkGray, textColor: .white)
            highestPriceButton.setUI(title: "  가격높은순  ", bgColor: .white, textColor: .label)
            lowestPriceButton.setUI(title: "  가격낮은순  ", bgColor: .white, textColor: .label)
        case .asc:
            accuracyButton.setUI(title: "  정확도  ", bgColor: .white, textColor: .label)
            dateButton.setUI(title: "  날짜순  ", bgColor: .white, textColor: .label)
            highestPriceButton.setUI(title: "  가격높은순  ", bgColor: .white, textColor: .label)
            lowestPriceButton.setUI(title: "  가격낮은순  ", bgColor: .darkGray, textColor: .white)
        case .dsc:
            accuracyButton.setUI(title: "  정확도  ", bgColor: .white, textColor: .label)
            dateButton.setUI(title: "  날짜순  ", bgColor: .white, textColor: .label)
            highestPriceButton.setUI(title: "  가격높은순  ", bgColor: .darkGray, textColor: .white)
            lowestPriceButton.setUI(title: "  가격낮은순  ", bgColor: .white, textColor: .label)
        }
    }
    
    func sortData() {
        // start 초기화
        start = 1
        DataStorage.shoppingList?.items = []
        guard let searchText = searchText else { return }
        APICall.shared.searchShopData(query: searchText, sort: sortType, start: start) { shopping in
            guard let shopping = shopping else { return }
            DataStorage.shoppingList = shopping
            self.resultCollecionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            self.resultCollecionView.reloadData()
        }
    }
    
    func fetch(type: SortType) {
        isLoading = true
        guard let searchText = searchText else { return }
        APICall.shared.searchShopData(query: searchText, sort: type, start: start) { shopping in
            guard let shopping = shopping else { return }
            DataStorage.shoppingList?.items.append(contentsOf: shopping.items)
            self.start += shopping.display
            self.isLoading = false
            self.resultCollecionView.reloadData()
        }
    }
    
    @objc func accuracyButtonClicked() {
        sortType = .sim
        configureFilterButtonUI()
    }
    
    @objc func dateButtonClicked() {
        sortType = .date
        configureFilterButtonUI()
    }
    
    @objc func highestButtonClicked() {
        sortType = .dsc
        configureFilterButtonUI()
    }
    
    @objc func lowestButtonClicked() {
        sortType = .asc
        configureFilterButtonUI()
    }
    
    @objc func wishButtonClicked(_ sender: UIButton) {
        guard let items = DataStorage.shoppingList?.items else { return }
        let index = sender.tag
        let item = items[index]
        
        // wishList에 존재하는 경우 -> 추가 안함(삭제)
        let wishList = DataStorage.fetchWishList()
        var newWishList = wishList
        if wishList.contains(item) {
            newWishList = wishList.filter{ $0.productId != item.productId }
        } else {
            // wishList에 없으면 추가
            newWishList.append(item)
        }
        
        let encoder = JSONEncoder()
        
        do {
            let result = try encoder.encode(newWishList)
            DataStorage.save(value: result, key: .wishList)
        } catch {
            showAlert(title: "Error!!", message: "정보를 업데이트 하는데 실패했습니다. 다시 시도해주세요.") { _ in
                print("encoding error: \(error)")
            }
        }
        
        resultCollecionView.reloadData()
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let items = DataStorage.shoppingList?.items else { return 0 }
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as? SearchResultCollectionViewCell else { return UICollectionViewCell() }
        if let inputText = searchText  {
            if let items = DataStorage.shoppingList?.items {
                cell.configureCell(item: items[indexPath.item], inputText: inputText)
                cell.wishButton.tag = indexPath.item
                cell.wishButton.addTarget(self, action: #selector(wishButtonClicked(_:)), for: .touchUpInside)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ItemDetailViewController()
        if let items = DataStorage.shoppingList?.items {
            vc.item = items[indexPath.item]
        }
        vc.index = indexPath.item
        vc.searchText = searchText
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let shoppingList = DataStorage.shoppingList else { return }
        print(shoppingList.items.count)
        if !isLoading && start <= maxStartValue {
            for indexPath in indexPaths {
                if shoppingList.items.count - 5 == indexPath.item {
                    fetch(type: sortType)
                }
            }
        }
    }
}
