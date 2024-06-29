//
//  ImageSettingViewController.swift
//  YEGZAG
//
//  Created by YJ on 6/13/24.
//

import UIKit

class ImageSettingViewController: UIViewController {
    let imageSettingView = ImageSettingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureCollecionView()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "이미지 선택"
        
        view.addSubview(imageSettingView)
        
        let safeArea = view.safeAreaLayoutGuide
        imageSettingView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
        
        imageSettingView.backgroundColor = .white
        
        if let userTempProfileImageName = DataStorage.userTempProfileImageName {
            // 이미지 선택 화면에 들어간적 있는 경우
            imageSettingView.profileImageView.image = UIImage(named: userTempProfileImageName)
        } else {
            // 처음 들어가는 경우
            imageSettingView.profileImageView.image = UIImage(named: DataStorage.fetchProfileImage())
        }
    }
    
    func configureCollecionView() {
        imageSettingView.selectImageCollectionView.dataSource = self
        imageSettingView.selectImageCollectionView.delegate = self
        imageSettingView.selectImageCollectionView.register(SelectImageCollectionViewCell.self, forCellWithReuseIdentifier: SelectImageCollectionViewCell.id)
    }
}

extension ImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataStorage.profileImageNameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectImageCollectionViewCell.id, for: indexPath) as? SelectImageCollectionViewCell else { return UICollectionViewCell() }
        let imageName = DataStorage.profileImageNameList[indexPath.item]
        cell.profileImageView.image = UIImage(named: imageName)
        cell.configureImage(imageName: imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImageName = DataStorage.profileImageNameList[indexPath.item]
        imageSettingView.profileImageView.image = UIImage(named: selectedImageName)
        DataStorage.userTempProfileImageName = selectedImageName
        imageSettingView.selectImageCollectionView.reloadData()
    }
}
