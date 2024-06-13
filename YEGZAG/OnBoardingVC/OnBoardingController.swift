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
            $0.top.equalTo(safeArea).offset(110)
            $0.horizontalEdges.equalTo(safeArea).inset(20)
        }
        
        startScreenImageView.snp.makeConstraints {
            $0.top.equalTo(logoLabel.snp.bottom).offset(90)
            $0.center.equalTo(safeArea)
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
        
        logoLabel.text = "YEGZAG"
        logoLabel.textColor = .systemPink
        logoLabel.font = .systemFont(ofSize: 50, weight: .black)
        logoLabel.textAlignment = .center
        
        startScreenImageView.image = UIImage(named: "launch")
        startScreenImageView.contentMode = .scaleAspectFill
    }
}

