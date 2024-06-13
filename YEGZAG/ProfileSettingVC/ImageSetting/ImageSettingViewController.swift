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
        // view
        view.backgroundColor = .white
        // navigation
        navigationItem.title = "프로필 설정"
        // imageSettingView
        view.addSubview(imageSettingView)
        
        let safeArea = view.safeAreaLayoutGuide
        imageSettingView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
        
        imageSettingView.backgroundColor = .white
        
        if let currentProfileImageName = DataStorage.userProfileImageName {
            imageSettingView.profileImageView.image = UIImage(named: currentProfileImageName)
        } else {
            imageSettingView.profileImageView.image = UIImage(resource: .profile0)
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
        DataStorage.userProfileImageName = selectedImageName
        imageSettingView.selectImageCollectionView.reloadData()
    }
}
