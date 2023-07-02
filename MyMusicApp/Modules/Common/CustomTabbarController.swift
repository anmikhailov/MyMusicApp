//
//  CustomTabbarController.swift
//  MyMusicApp
//
//  Created by Andrey on 29.06.2023.
//

import UIKit

enum Tabs: Int {
    case home
    case explore
    case favorites
    case account
}

final class CustomTabbarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        configure()
        setTabbarAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let homeController = HomeViewController()
        let exploreController = ExploreViewController()
        let favoritesController = FavoritesAssembly.configuredModule()
        let accountController = AccountViewController()
        
        let homeNavigationController = BaseNavigationController(rootViewController: homeController)
        let exploreNavigationController = BaseNavigationController(rootViewController: exploreController)
        let favoritesNavigationController = BaseNavigationController(rootViewController: favoritesController)
        let accountNavigationController = BaseNavigationController(rootViewController: accountController)
        
        
        homeNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.home,
                                                           image: Resources.Icons.TabBar.home,
                                                           tag: Tabs.home.rawValue)
        exploreNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.explore,
                                                              image: Resources.Icons.TabBar.explore,
                                                              tag: Tabs.explore.rawValue)
        favoritesNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.favorites,
                                                                image: Resources.Icons.TabBar.favorites,
                                                                tag: Tabs.favorites.rawValue)
        accountNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.account,
                                                              image: Resources.Icons.TabBar.account,
                                                              tag: Tabs.account.rawValue)
        
        setViewControllers([
            homeNavigationController,
            exploreNavigationController,
            favoritesNavigationController,
            accountNavigationController,
        ], animated: false)
        
        
    }
    
    private func setTabbarAppearance() {
        let positionOnX: CGFloat = 0
        let positionOnY: CGFloat = 8
        let width = tabBar.bounds.width
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: 0
        )
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.backgroundColor.cgColor
        
        tabBar.tintColor = Resources.Colors.TabBarColors.active
        tabBar.barTintColor = Resources.Colors.TabBarColors.inactive
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: Resources.Fonts.RobotoRegular(with: 16)], for: .normal)
    }
}
