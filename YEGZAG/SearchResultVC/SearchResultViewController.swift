//
//  SearchResultViewController.swift
//  YEGZAG
//
//  Created by YJ on 6/15/24.
//

import UIKit
import SnapKit

final class SearchResultViewController: UIViewController {
    private let topElementView = UIView()
    private let entireResultCountLabel = UILabel()
    private let filterButtonStackView = UIStackView()
    private let accuracyButton = UIButton()
    private let dateButton = UIButton()
    private let highestPriceButton = UIButton()
    private let lowestPriceButton = UIButton()
    
    private let resultCollecionView = UICollectionView(frame: .zero, collectionViewLayout: CollecionViewLayout())
    var searchText: String?
    
    private var isLoading: Bool = false
    private var start = 1
    private let maxStartValue = 1000
    private var sortType: SortType = .sim {
        didSet {
            sortData()
        }
    }
    
    var shoppingList: Shopping?
    
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
    
    private func configureView() {
        // view
        view.backgroundColor = .white
        // navigation
        navigationItem.title = searchText
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    private func configureCollecionView() {
        resultCollecionView.delegate = self
        resultCollecionView.dataSource = self
        resultCollecionView.prefetchDataSource = self
        resultCollecionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
    }
    
    private func configureHierarchy() {
        view.addSubview(topElementView)
        topElementView.addSubview(entireResultCountLabel)
        topElementView.addSubview(filterButtonStackView)
        filterButtonStackView.addArrangedSubview(accuracyButton)
        filterButtonStackView.addArrangedSubview(dateButton)
        filterButtonStackView.addArrangedSubview(highestPriceButton)
        filterButtonStackView.addArrangedSubview(lowestPriceButton)
        
        view.addSubview(resultCollecionView)
    }
    
    private func configureLayout() {
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
    
    private func configureUI() {
        let resultCount = shoppingList?.total ?? 0
        entireResultCountLabel.setUI(labelText: "\(resultCount.formatted())개의 검색 결과", txtColor: .primaryColor, fontStyle: .systemFont(ofSize: 16, weight: .bold), txtAlignment: .left)
        
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
    
    private static func CollecionViewLayout() -> UICollectionViewLayout {
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
    
    private func configureFilterButtonUI() {
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
    
    private func sortData() {
        // start 초기화
        start = 1
        shoppingList?.items = []
        guard let searchText = searchText else { return }
        
        APICall.shared.callRequest(query: searchText, sort: sortType, start: start, model: Shopping.self) { shopping, error in
            guard let shopping = shopping else { return }
            self.shoppingList = shopping
            self.resultCollecionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            self.resultCollecionView.reloadData()
        }
    }
    
    private func fetch(type: SortType) {
        isLoading = true
        guard let searchText = searchText else { return }
        
        APICall.shared.callRequest(query: searchText, sort: type, start: start, model: Shopping.self) { shopping, error in
            guard let shopping = shopping else { return }
            self.shoppingList?.items.append(contentsOf: shopping.items)
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
        guard let items = shoppingList?.items else { return }
        let index = sender.tag
        let item = items[index]
        
        let itemRealm = ItemRealm(
            productId: item.productId,
            title: item.title,
            link: item.link,
            image: item.image,
            lprice: item.lprice,
            mallName: item.mallName,
            brand: item.brand)
        
        if sender.isSelected {
            RealmManager.shared.delete(item: itemRealm)
            resultCollecionView.reloadData()
        } else {
            showJimAlert(itemRealm: itemRealm)
        }
    }
    
    func showJimAlert(itemRealm: ItemRealm) {
        let alert = UIAlertController(title: "보관할 목록을 선택해주세요", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        let folderList = RealmManager.shared.fetchFolder()
        
        for folder in folderList {
            let alertAction = UIAlertAction(title: folder.name, style: .default) { _ in
                RealmManager.shared.addItem(itemRealm, folder: folder)
                self.resultCollecionView.reloadData()
            }
            
            alert.addAction(alertAction)
        }
    
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let items = shoppingList?.items else { return 0 }
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as? SearchResultCollectionViewCell else { return UICollectionViewCell() }
        if let inputText = searchText, let items = shoppingList?.items  {
            let item = items[indexPath.item]
            cell.wishButton.tag = indexPath.item
            cell.configureSearchCell(item: item, inputText: inputText)
            
            cell.wishButton.addTarget(self, action: #selector(wishButtonClicked(_:)), for: .touchUpInside)
            let wishList = RealmManager.shared.fetch()
            
            if wishList.filter({ $0.productId == item.productId }).first != nil {
                cell.selectedStyle()
            } else {
                cell.unselectedStyle()
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ItemDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let shoppingList = shoppingList else { return }
        if !isLoading && start <= maxStartValue {
            for indexPath in indexPaths {
                if shoppingList.items.count - 5 == indexPath.item {
                    fetch(type: sortType)
                }
            }
        }
    }
}
