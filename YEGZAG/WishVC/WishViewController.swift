//
//  WishViewController.swift
//  YEGZAG
//
//  Created by YJ on 7/6/24.
//

import UIKit
import SnapKit

class WishViewController: UIViewController {
    let wishCollecionView = UICollectionView(frame: .zero, collectionViewLayout: CollecionViewLayout())
    var wishList: [ItemRealm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    
    func fetchData() {
        let objects = RealmManager.shared.fetch()
        wishList = objects.filter { $0.isLike }
        wishCollecionView.reloadData()
    }
    
    func configureHierarchy() {
        view.addSubview(wishCollecionView)
    }
    
    func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        wishCollecionView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        title = "찜 목록"
    }
    
    func configureCollectionView() {
        wishCollecionView.delegate = self
        wishCollecionView.dataSource = self
        wishCollecionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
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
    
    @objc func wishButtonClicked(_ sender: UIButton) {
        let item = wishList[sender.tag]
        let itemRealm = ItemRealm(
            productId: item.productId,
            title: item.title,
            link: item.link,
            image: item.image,
            lprice: item.lprice,
            mallName: item.mallName,
            brand: item.brand)
        
        if sender.isSelected  {
            itemRealm.isLike = false
            RealmManager.shared.update(item: itemRealm)
        } else {
            RealmManager.shared.update(item: itemRealm)
        }
        
        wishCollecionView.reloadData()
    }
}

extension WishViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as? SearchResultCollectionViewCell else { return UICollectionViewCell() }
        cell.wishButton.tag = indexPath.item
        cell.wishButton.addTarget(self, action: #selector(wishButtonClicked), for: .touchUpInside)
        let item = wishList[indexPath.item]
        cell.configureWishCell(item: item)
        
        if let selectedItem = wishList.filter({ $0.productId == item.productId }).first {
            if selectedItem.isLike {
                cell.selectedStyle()
            } else {
                cell.unselectedStyle()
            }
        } else {
            cell.unselectedStyle()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ItemDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
