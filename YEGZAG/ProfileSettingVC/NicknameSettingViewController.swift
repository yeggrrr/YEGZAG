//
//  NicknameSettingViewController.swift
//  YEGZAG
//
//  Created by YJ on 6/13/24.
//

import UIKit
import SnapKit

class NicknameSettingViewController: UIViewController {
    let nicknameSettingView = NicknameSettingView()
    
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
        view.addSubview(nicknameSettingView)
        
        let safeArea = view.safeAreaLayoutGuide
        nicknameSettingView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
        
        nicknameSettingView.backgroundColor = .white
    }
}
