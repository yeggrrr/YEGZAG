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
    let accuracyButton = FilterButton(title: "  정확도  ", bgColor: .darkGray, textColor: .white)
    let dateButton = FilterButton(title: "  날짜순  ", bgColor: .white, textColor: .label)
    let highestPriceButton = FilterButton(title: "  가격높은순  ", bgColor: .white, textColor: .label)
    let lowestPriceButton = FilterButton(title: "  가격낮은순  ", bgColor: .white, textColor: .label)
    
    let resultCollecionView = UICollectionView(frame: .zero, collectionViewLayout: CollecionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureCollecionView()
    }
    
    func configureView() {
        // view
        view.backgroundColor = .white
        // navigation
        navigationItem.title = "검색한 아이템 이름"
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
            $0.bottom.equalTo(view)
        }
    }
    
    func configureUI() {
        entireResultCountLabel.text = "345,445개의 검색 결과"
        entireResultCountLabel.font = .systemFont(ofSize: 16, weight: .bold)
        entireResultCountLabel.textColor = .systemPink
        entireResultCountLabel.textAlignment = .left
        
        filterButtonStackView.axis = .horizontal
        filterButtonStackView.spacing = 10
        filterButtonStackView.alignment = .leading
        filterButtonStackView.distribution = .fillProportionally
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

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as? SearchResultCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(ItemDetailViewController(), animated: true)
    }
}
