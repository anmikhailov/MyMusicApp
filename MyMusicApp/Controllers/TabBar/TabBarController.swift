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
    
    // MARK: - Properties
    let notificationManager = NotificationManager()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationManager.userNotificationPermission()
        notificationManager.sendNotification(title: "Greetings! 🥰", body: "You can turn off notifications in Account settings ⚙️")
        notificationManager.notificationCenter.delegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        tabBar.tintColor = Resources.Colors.TabBarColors.active
        //tabBar.barTintColor = Resources.Colors.TabBarColors.inactive
        tabBar.backgroundColor = Resources.Colors.TabBarColors.background
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        
        let homeController = HomeViewController()
        let exploreController = ExploreViewController()
        let favoritesController = FavoritesViewController()
        let accountController = AccountViewController()
        
        let homeNavigationController = UINavigationController(rootViewController: homeController)
        let exploreNavigationController = UINavigationController(rootViewController: exploreController)
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesController)
        let accountNavigationController = UINavigationController(rootViewController: accountController)
        
        
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
}


// MARK: - Notifications delegate
extension TabBarController: UNUserNotificationCenterDelegate {
    
    //method that shows notification badge at any time we need it
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    //user tap on badge and go to the screen we need using TabBarController
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let tabBarController = windowScene.windows.first?.rootViewController as? TabBarController else {
            completionHandler()
            return
        }
        // Получение индекса экрана, на который вы хотите перейти
        let desiredTabIndex = Tabs.account.rawValue // Здесь используется "Account" экран
        
        // Переключение на целевой экран
        tabBarController.selectedIndex = desiredTabIndex
        completionHandler()
    }
    
}
