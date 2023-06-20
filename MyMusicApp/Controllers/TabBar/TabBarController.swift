
//
//  File.swift
//  MyMusicApp
//
//  Created by Andrey on 11.06.2023.
//

import UIKit

enum Tabs: Int {
    case home
    case explore
    case favorites
    case account
}

final class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        tabBar.tintColor = Resources.Colors.TabBarColors.active
        tabBar.barTintColor = Resources.Colors.TabBarColors.inactive
        tabBar.backgroundColor = Resources.Colors.TabBarColors.background
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: .normal)

        let homeController = HomeViewController()
        let exploreController = ExploreViewController()
        let favoritesController = FavoritesViewController()
        let accountController = AccountViewController()

        let homeNavigation = UINavigationController(rootViewController: homeController)


        homeNavigation.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.home,
                                                 image: Resources.Icons.TabBar.home,
                                                 tag: Tabs.home.rawValue)
        exploreController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.explore,
                                                 image: Resources.Icons.TabBar.explore,
                                                 tag: Tabs.explore.rawValue)
        favoritesController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.favorites,
                                                 image: Resources.Icons.TabBar.favorites,
                                                 tag: Tabs.favorites.rawValue)
        accountController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.account,
                                                 image: Resources.Icons.TabBar.account,
                                                 tag: Tabs.account.rawValue)

        setViewControllers([
            homeNavigation,
            exploreController,
            favoritesController,
            accountController,
        ], animated: false)


    }
}
