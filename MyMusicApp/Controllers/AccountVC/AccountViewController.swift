//
//  AccountViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 11.06.2023.
//

import UIKit
import SnapKit

class AccountViewController: UIViewController {
    
    var accountLabel = UILabel()
    var libraryLabel = UILabel()
    var setingsButton = UIButton(type: .system)
    var profileImageView: UIImageView!
    let myPlayListButton = AccountUIButton(labelText: "My playlist", imageAfterText: UIImage(systemName: "chevron.right"), imageBeforeText: UIImage(systemName: "music.note"))
    let notificationButton = AccountUIButton(labelText: "Notification", imageAfterText: nil, imageBeforeText: UIImage(systemName: "bell"))
    let downloadButton = AccountUIButton(labelText: "Download", imageAfterText: UIImage(systemName: "chevron.right"), imageBeforeText: UIImage(systemName: "square.and.arrow.down"))
    let singOutButton = UIButton(type: .system)
    

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

    }
    
    
    func SetBacgroundColors(){
        view.backgroundColor = Resources.Colors.TabBarColors.background
    }
    
    func setProfileLabel(){
        view.addSubview(accountLabel)
        accountLabel.text = "Account"
        accountLabel.font = setFont(nameFont: "Roboto-Bold", sizeFont: 48)
        accountLabel.textColor = .white
        
        accountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64) // Отступ от верха на 64 пункта
            make.left.equalToSuperview().offset(24)
        }
    }
    
    func setSetingsButton(){
        view.addSubview(setingsButton)
        setingsButton.setImage(UIImage(systemName:"gearshape"), for: .normal)
        setingsButton.tintColor = .white
        setingsButton.imageView?.contentMode = .scaleAspectFit
        
        setingsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(86) // Отступ от верха на 86 пункта
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
            make.top.equalToSuperview().offset(268)
            make.left.equalToSuperview().offset(24)
        }
    }
    
    func setMyPlatListButton(){
        view.addSubview(myPlayListButton)
        
        myPlayListButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(300)
            make.height.equalTo(56)
            
        }
    }
    
    func setNotificationButton(){
        view.addSubview(notificationButton)
        
        notificationButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(350)
            make.height.width.equalTo(56)
            
        }
    }
    
    func setDownloadButton(){
        view.addSubview(downloadButton)
        
        downloadButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(400)
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
        setingsButton.addTarget(self, action: #selector(settingsButtonTupped), for: .touchUpInside)
    }
    
    @objc func settingsButtonTupped() {
        let settingsViewController = SettingsViewController()
        print("tupped")
//        navigationController?.pushViewController(settingsViewController, animated: true)
        settingsViewController.modalPresentationStyle = .fullScreen
        self.present(settingsViewController, animated: true)
        }
    
}


#if DEBUG

import SwiftUI

struct AccountViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = AccountViewController

    func makeUIViewController(context: Context) -> UIViewControllerType {
        AccountViewController(nibName: nil, bundle: nil)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
}

struct AccountViewController_Previews: PreviewProvider {
    static var previews: some View {
        AccountViewControllerRepresentable()
    }
}

#endif
