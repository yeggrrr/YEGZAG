//
//  YEGZAGTabBarController.swift
//  YEGZAG
//
//  Created by YJ on 6/14/24.
//

import UIKit

class YEGZAGTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    func configureTabBar() {
        tabBar.tintColor = .systemPink
        tabBar.unselectedItemTintColor = .darkGray
        
        let searchVC = MainViewController()
        let searchNav = UINavigationController(rootViewController: searchVC)
        searchNav.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let settingVC = SettingViewController()
        let settingNav = UINavigationController(rootViewController: settingVC)
        settingNav.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape"), tag: 1)
        
        setViewControllers([searchNav, settingNav], animated: true)
    }
}
