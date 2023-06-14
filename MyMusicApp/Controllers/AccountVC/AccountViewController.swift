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
    let myPlayListButton = AccountUIButton(labelText: "My playlist", image: UIImage(systemName: "chevron.right"))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        SetBacgroundColors()
        setProfileLabel()
        setSetingsButton()
        setProfileImage()
        setLibraryLabel()
        setMyPlatListButton()

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
    
    func setFont(nameFont:String, sizeFont:CGFloat) -> UIFont {
        if let customFont = UIFont(name: nameFont, size: sizeFont){
            return customFont
        }
        else{
            print("Eror Font")
            return UIFont.systemFont(ofSize: sizeFont, weight: .bold)
        }
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
