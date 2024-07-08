//
//  YEGZAGTabBarController.swift
//  YEGZAG
//
//  Created by YJ on 6/14/24.
//

import UIKit

final class YEGZAGTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    private func configureTabBar() {
        tabBar.tintColor = .primaryColor
        tabBar.unselectedItemTintColor = .darkGray
        
        let searchVC = MainViewController()
        let searchNav = UINavigationController(rootViewController: searchVC)
        searchNav.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let selectedListVC = SelectedListViewController()
        let selectedListNav = UINavigationController(rootViewController: selectedListVC)
        selectedListNav.tabBarItem = UITabBarItem(title: "찜", image: UIImage(systemName: "heart"), tag: 1)
        
        
        let settingVC = SettingViewController()
        let settingNav = UINavigationController(rootViewController: settingVC)
        settingNav.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape"), tag: 2)
        
        setViewControllers([searchNav, selectedListNav, settingNav], animated: true)
    }
}
