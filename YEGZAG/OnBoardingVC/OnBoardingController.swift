//
//  OnBoardingController.swift
//  YEGZAG
//
//  Created by YJ on 6/13/24.
//

import UIKit
import SnapKit

class OnBoardingController: UIViewController {
    let logoLabel = UILabel()
    let startScreenImageView = UIImageView()
    let startButton = PointButton(title: "시작하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy() {
        view.addSubview(logoLabel)
        view.addSubview(startScreenImageView)
        view.addSubview(startButton)
    }

    func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        logoLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeArea).inset(20)
            $0.height.equalTo(40)
        }
        
        startScreenImageView.snp.makeConstraints {
            $0.centerX.equalTo(safeArea.snp.centerX)
            $0.top.equalTo(logoLabel.snp.bottom).offset(90)
            $0.bottom.equalTo(startButton.snp.top).offset(-150)
        }
        
        startButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeArea).inset(20)
            $0.bottom.equalTo(safeArea).inset(30)
            $0.height.equalTo(50)
        }
    }
    
    func configureUI() {
        // view
        view.backgroundColor = .white
        
        // navigation
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        
        logoLabel.setUI(labelText: "YEGZAG", txtColor: .systemPink, fontStyle: .systemFont(ofSize: 50, weight: .black), txtAlignment: .center)
        
        startScreenImageView.image = UIImage(named: "launch")
        startScreenImageView.contentMode = .scaleAspectFill
        
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        navigationController?.pushViewController(NicknameSettingViewController(), animated: true)
    }
}

