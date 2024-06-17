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
    
    var start = 1
    
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
        entireResultCountLabel.text = "\(resultCount.formatted())개의 검색 결과"
        entireResultCountLabel.font = .systemFont(ofSize: 16, weight: .bold)
        entireResultCountLabel.textColor = .systemPink
        entireResultCountLabel.textAlignment = .left
        
        filterButtonStackView.axis = .horizontal
        filterButtonStackView.spacing = 10
        filterButtonStackView.alignment = .leading
        filterButtonStackView.distribution = .fillProportionally
        
        accuracyButton.setUI(title: "  정확도  ",  bgColor: .darkGray, textColor: .white)
        dateButton.setUI(title: "  날짜순  ", bgColor: .white, textColor: .label)
        highestPriceButton.setUI(title: "  가격높은순  ", bgColor: .white, textColor: .label)
        lowestPriceButton.setUI(title: "  가격낮은순  ", bgColor: .white, textColor: .label)
        
        accuracyButton.addTarget(self, action: #selector(accuracyButtonClicked), for: .touchUpInside)
        dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        highestPriceButton.addTarget(self, action: #selector(highestButtonClicked), for: .touchUpInside)
        lowestPriceButton.addTarget(self, action: #selector(lowestButtonClicked), for: .touchUpInside)
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
    
    @objc func accuracyButtonClicked() {
        sortData(type: .sim)
        accuracyButton.setUI(title: "  정확도  ", bgColor: .darkGray, textColor: .white)
        dateButton.setUI(title: "  날짜순  ", bgColor: .white, textColor: .label)
        highestPriceButton.setUI(title: "  가격높은순  ", bgColor: .white, textColor: .label)
        lowestPriceButton.setUI(title: "  가격낮은순  ", bgColor: .white, textColor: .label)
    }
    
    @objc func dateButtonClicked() {
        sortData(type: .date)
        accuracyButton.setUI(title: "  정확도  ", bgColor: .white, textColor: .label)
        dateButton.setUI(title: "  날짜순  ", bgColor: .darkGray, textColor: .white)
        highestPriceButton.setUI(title: "  가격높은순  ", bgColor: .white, textColor: .label)
        lowestPriceButton.setUI(title: "  가격낮은순  ", bgColor: .white, textColor: .label)
    }
    
    @objc func highestButtonClicked() {
        sortData(type: .dsc)
        accuracyButton.setUI(title: "  정확도  ", bgColor: .white, textColor: .label)
        dateButton.setUI(title: "  날짜순  ", bgColor: .white, textColor: .label)
        highestPriceButton.setUI(title: "  가격높은순  ", bgColor: .darkGray, textColor: .white)
        lowestPriceButton.setUI(title: "  가격낮은순  ", bgColor: .white, textColor: .label)
    }
    
    @objc func lowestButtonClicked() {
        sortData(type: .asc)
        accuracyButton.setUI(title: "  정확도  ", bgColor: .white, textColor: .label)
        dateButton.setUI(title: "  날짜순  ", bgColor: .white, textColor: .label)
        highestPriceButton.setUI(title: "  가격높은순  ", bgColor: .white, textColor: .label)
        lowestPriceButton.setUI(title: "  가격낮은순  ", bgColor: .darkGray, textColor: .white)
    }
    
    func sortData(type: SortType) {
        guard let searchText = searchText else { return }
        APICall.shared.searchShopData(query: searchText, sort: type, start: start) { shopping in
            guard let shopping = shopping else { return }
            DataStorage.shoppingList = shopping
            self.resultCollecionView.reloadData()
            self.resultCollecionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }    }
    
    @objc func wishButtonClicked(_ sender: UIButton) {
        guard let items = DataStorage.shoppingList?.items else { return }
        let index = sender.tag
        let item = items[index]
        
        let wishList = DataStorage.fetchWishList()
        var newWishList = wishList
        if wishList.contains(item) {
            newWishList = wishList.filter{ $0.productId != item.productId }
        } else {
            newWishList.append(item)
        }
        
        let encoder = JSONEncoder()
        
        do {
            let result = try encoder.encode(newWishList)
            DataStorage.save(value: result, key: .wishList)
        } catch {
            print("encoding error: \(error)")
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
        if let items = DataStorage.shoppingList?.items {
            cell.configureCell(item: items[indexPath.item])
            cell.wishButton.tag = indexPath.item
            cell.wishButton.addTarget(self, action: #selector(wishButtonClicked(_:)), for: .touchUpInside)
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
