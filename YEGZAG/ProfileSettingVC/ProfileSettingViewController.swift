//
//  ProfileSettingViewController.swift
//  YEGZAG
//
//  Created by YJ on 6/13/24.
//

import UIKit
import SnapKit

class ProfileSettingViewController: UIViewController {
    let profileSettingView = ProfileSettingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        // view
        view.backgroundColor = .white
        // navigation
        navigationItem.title = "프로필 설정"
        // profileSettingView
        view.addSubview(profileSettingView)
        
        let safeArea = view.safeAreaLayoutGuide
        profileSettingView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
        profileSettingView.backgroundColor = .white
    }
}
