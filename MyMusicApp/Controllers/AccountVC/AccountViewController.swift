//
//  AccountViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 11.06.2023.
//

import UIKit
import SnapKit
import UserNotifications

class AccountViewController: UIViewController {
    
    // MARK: - Properties
    let notificationManager = NotificationManager()
    
    // MARK: - UI Components
    var accountLabel = UILabel()
    var libraryLabel = UILabel()
    var setingsButton = UIButton(type: .system)
    var profileImageView: UIImageView!
    let myPlayListButton = AccountUIButton(labelText: "My playlist", imageAfterText: UIImage(systemName: "chevron.right"), imageBeforeText: UIImage(systemName: "music.note"))
    let notificationButton = AccountUIButton(labelText: "Notification", imageAfterText: nil, imageBeforeText: UIImage(systemName: "bell"))
    let downloadButton = AccountUIButton(labelText: "Download", imageAfterText: UIImage(systemName: "chevron.right"), imageBeforeText: UIImage(systemName: "square.and.arrow.down"))
    let singOutButton = UIButton(type: .system)
    var nameUserLabel = UILabel()
    var emailUserLabel = UILabel()
    var userInfo:UserInfo?
    
    #warning("Не знаю как переделать на snp")
    private lazy var notificationSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.isOn = true
        uiSwitch.onTintColor = Resources.Colors.brand1
        uiSwitch.backgroundColor = .gray
        uiSwitch.thumbTintColor = .white
        uiSwitch.layer.cornerRadius = 16
        uiSwitch.addTarget(self, action: #selector(changeNotificationsMode), for: .valueChanged)
        return uiSwitch
    }()
    
    @objc private func changeNotificationsMode(sender: UISwitch) {
        if sender.isOn {
            //notifications enabled
            notificationManager.sendNotification(title: "Notifications", body: "Are on")
        } else {
            //notifications disabled
            notificationManager.sendNotification(title: "Notifications", body: "Are off")
            notificationManager.notificationCenter.removeAllPendingNotificationRequests()
            notificationManager.notificationCenter.removeAllDeliveredNotifications()
        }
    }
    
    #warning("Не знаю как переделать на snp")
    // MARK: - UI Setup
    func setupUI() {
        view.addSubview(notificationSwitch)
        
        notificationSwitch.snp.makeConstraints { make in
            make.leading.equalTo(notificationButton.snp.trailing).offset(-50)
            make.centerY.equalTo(notificationButton)
            make.width.equalTo(10)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        SetBacgroundColors()
        setProfileLabel()
        setSetingsButton()
        setProfileImage()
        setLibraryLabel()
        setMyPlatListButton()
        setNotificationButton()
        setDownloadButton()
        setSignOutButton()
        setTargetForButton()
        
        setupUI()
        
        notificationManager.notificationCenter.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userInfo = FirebaseManager.shared.getFromUserDefaultsUserInfo()
        setNameUserLabel()
        setEmailUserLabel()
    }
    
//MARK: - Func
    func SetBacgroundColors(){
        view.backgroundColor = Resources.Colors.TabBarColors.background
    }
    
    func setProfileLabel(){
        view.addSubview(accountLabel)
        accountLabel.text = "Account"
        accountLabel.font = setFont(nameFont: "Roboto-Bold", sizeFont: 48)
        accountLabel.textColor = .white
        
        accountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.left.equalToSuperview().offset(24)
        }
    }
    
    func setSetingsButton(){
        view.addSubview(setingsButton)
        setingsButton.setImage(UIImage(systemName:"gearshape"), for: .normal)
        setingsButton.tintColor = .white
        setingsButton.imageView?.contentMode = .scaleAspectFit
        
        setingsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(86)
            make.right.equalToSuperview().inset(24)
        }
    }
    
    func setProfileImage(){
        profileImageView = UIImageView()
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
//        profileImageView.layer.borderWidth = 2
//        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.image = UIImage(systemName: "person")
        profileImageView.tintColor = .white
        
        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(137)
            make.left.equalToSuperview().offset(24)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
    }
    
    func setLibraryLabel(){
        view.addSubview(libraryLabel)
        
        libraryLabel.text = "Library"
        libraryLabel.font = setFont(nameFont: "Roboto-Medium", sizeFont: 22)
        libraryLabel.textColor = .white
        
        libraryLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(32)
            make.leading.equalToSuperview().inset(24)
        }
    }
    
    func setMyPlatListButton(){
        view.addSubview(myPlayListButton)
        
        myPlayListButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(libraryLabel.snp.bottom).offset(20)
            make.height.equalTo(56)
            
        }
    }
    
    func setNotificationButton(){
        view.addSubview(notificationButton)
        
        notificationButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(myPlayListButton.snp.bottom)
            make.height.width.equalTo(56)
            
        }
    }
    
    func setDownloadButton(){
        view.addSubview(downloadButton)
        
        downloadButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(notificationButton.snp.bottom)
            make.height.equalTo(56)
        }
    }
    
    func setSignOutButton(){
        view.addSubview(singOutButton)
        singOutButton.backgroundColor = Resources.Colors.TabBarColors.background
        singOutButton.layer.borderColor = Resources.Colors.brand1.cgColor
        singOutButton.layer.borderWidth = 2.0
        singOutButton.layer.cornerRadius = 5.0
                
        singOutButton.setTitleColor(Resources.Colors.brand1, for: .normal)
        singOutButton.setTitle("SIGN OUT", for: .normal)
        singOutButton.titleLabel?.font = setFont(nameFont: "Roboto-Bold", sizeFont: 16)
                
        singOutButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(38)
            make.width.equalTo(195)
            make.height.equalTo(46)
        }
        
        singOutButton.addTarget(self, action: #selector(singOutTapped), for: .touchUpInside)
    }
    
    func setNameUserLabel(){
        view.addSubview(nameUserLabel)
        nameUserLabel.font = setFont(nameFont: "Roboto-Medium", sizeFont: 18)
        nameUserLabel.text = userInfo?.name
        nameUserLabel.textColor = .white
        
        nameUserLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top).offset(10)
            make.leading.equalTo(profileImageView.snp.trailing).offset(20)
        }
    }
    
    func setEmailUserLabel(){
        view.addSubview(emailUserLabel)
        emailUserLabel.font = setFont(nameFont: "Roboto-Medium", sizeFont: 14)
        emailUserLabel.text = userInfo?.email
        emailUserLabel.textColor = .gray
        
        emailUserLabel.snp.makeConstraints { make in
            make.top.equalTo(nameUserLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameUserLabel.snp.leading)
        }
    }
    
    func setFont(nameFont:String, sizeFont:CGFloat) -> UIFont {
        if let customFont = UIFont(name: nameFont, size: sizeFont){
            return customFont
        }
        else{
            print("Eror Font")
            fatalError("Eror Font")
        }
    }
    
    func setTargetForButton(){
        setingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        myPlayListButton.addTarget(self, action: #selector(myPlayListTapped), for: .touchUpInside)
        
        notificationButton.addTarget(self, action: #selector(notificationTapped), for: .touchUpInside)
        
        downloadButton.addTarget(self, action: #selector(downloadTapped), for: .touchUpInside)
    }
//MARK: - @OBJC Func
    @objc func settingsButtonTapped() {
        let settingsViewController = SettingsViewController()
        print("tupped")
//        navigationController?.pushViewController(settingsViewController, animated: true)
        settingsViewController.modalPresentationStyle = .fullScreen
        self.present(settingsViewController, animated: true)
        }
    
    @objc func singOutTapped(){
        UserDefaults.standard.setValue(nil, forKey: "access_token")
        FirebaseManager.shared.signOut {
            print("Sing Out")
        }
    }
    
    @objc func myPlayListTapped(){
        print("My Playlist open ")
    }
    
    @objc func notificationTapped() {
        guard notificationSwitch.isOn else {
            return
        }
        
        print("Notification open")
        notificationManager.sendNotification(title: "Hello there!", body: "You can turn this off 😃")
    }
    
    @objc func downloadTapped(){
        let targetVc = DownloadedViewController()
        targetVc.modalPresentationStyle = .fullScreen
        self.present(targetVc, animated: true)
    }
    
}

// MARK: - Notifications delegate
extension AccountViewController: UNUserNotificationCenterDelegate {
    
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

#if DEBUG

//import SwiftUI
//
//struct AccountViewControllerRepresentable: UIViewControllerRepresentable {
//    typealias UIViewControllerType = AccountViewController
//
//    func makeUIViewController(context: Context) -> UIViewControllerType {
//        AccountViewController(nibName: nil, bundle: nil)
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//        APICaller.shared.getCurrentUserProfile { result in
//            switch result {
//            case .success(let model):
//                break
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
//
//struct AccountViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountViewControllerRepresentable()
//    }
//}

#endif
