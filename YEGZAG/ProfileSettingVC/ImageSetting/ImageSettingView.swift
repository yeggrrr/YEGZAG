//
//  ImageSettingView.swift
//  YEGZAG
//
//  Created by YJ on 6/13/24.
//

import UIKit
import SnapKit

final class ImageSettingView: UIView {
    private let profileView = UIView()
    let profileImageView = UIImageView()
    private let profileBorderView = UIView()
    private let camerView = UIView()
    private let cameraImageView = UIImageView()
    
    let selectImageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collecionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        addSubview(profileView)
        profileView.addSubview(profileBorderView)
        profileBorderView.addSubview(profileImageView)
        addSubview(camerView)
        camerView.addSubview(cameraImageView)
        
        addSubview(selectImageCollectionView)
    }
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        profileView.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(150)
        }
        
        profileBorderView.snp.makeConstraints {
            $0.center.equalTo(profileView.snp.center)
            $0.width.height.equalTo(100)
        }
        
        profileImageView.snp.makeConstraints {
            $0.center.equalTo(profileBorderView.snp.center)
            $0.width.height.equalTo(100)
        }
        
        camerView.snp.makeConstraints {
            $0.trailing.equalTo(profileBorderView.snp.trailing)
            $0.bottom.equalTo(profileBorderView.snp.bottom)
            $0.width.height.equalTo(40)
        }
        
        cameraImageView.snp.makeConstraints {
            $0.center.equalTo(camerView.snp.center)
            $0.width.height.equalTo(22)
        }
        
        selectImageCollectionView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(safeArea).inset(15)
            $0.height.equalTo(300)
        }
    }
    
    private func configureUI() {
        profileView.backgroundColor = .white
        
        profileBorderView.layer.borderWidth = 3
        profileBorderView.layer.borderColor = UIColor.primaryColor.cgColor
        profileBorderView.layer.opacity = 1
        
        profileBorderView.layoutIfNeeded()
        profileBorderView.layer.cornerRadius = profileBorderView.frame.width / 2
        profileBorderView.clipsToBounds = true
        
        profileImageView.contentMode = .scaleAspectFill
        
        camerView.layer.cornerRadius = 20
        camerView.backgroundColor = .primaryColor
        
        cameraImageView.image = UIImage(systemName: "camera.fill")
        cameraImageView.tintColor = .white
        cameraImageView.layer.cornerRadius = 11
        
        selectImageCollectionView.backgroundColor = .white
        selectImageCollectionView.isScrollEnabled = false
    }
    
    private static func collecionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 1
        let cellSpacing: CGFloat = 1
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 2) - 30
        layout.itemSize = CGSize(width: width / 4, height: width / 4)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
}
