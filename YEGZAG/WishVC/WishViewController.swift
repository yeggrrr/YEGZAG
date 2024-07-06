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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureCollectionView()
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
        
        wishCollecionView.backgroundColor = .systemGray5
    }
    
    func configureCollectionView() {
        wishCollecionView.delegate = self
        wishCollecionView.dataSource = self
        wishCollecionView.register(WishCollectionViewCell.self, forCellWithReuseIdentifier: WishCollectionViewCell.id)
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
}

extension WishViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishCollectionViewCell.id, for: indexPath) as? WishCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}
