//
//  NotificationManager.swift
//  MyMusicApp
//
//  Created by Марк Райтман on 24.06.2023.
//

import UIKit
import UserNotifications

open class NotificationManager: UIViewController {
    
    // MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Notification
    public let notificationCenter = UNUserNotificationCenter.current()

    public func userNotificationPermission() {
        //ask the permission from user
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            guard granted else { return }
            self.notificationCenter.getNotificationSettings { (settings) in
                print(settings)
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
    }

    public func sendNotification() {
        //create notification content
        let content = UNMutableNotificationContent()
        content.title = "Greetings! 🥰"
        content.body = " You can turn off notifications in Account settings ⚙️"
        content.sound = UNNotificationSound.default
        
        //create the notification trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //create the request
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        //register the notification request
        notificationCenter.add(request) { (error) in
            print(error?.localizedDescription as Any)
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    
    // MARK: - Notifications delegate
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
        print(#function)
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
        //user tap on badge and go to the screen we need
        let vc = AccountViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
