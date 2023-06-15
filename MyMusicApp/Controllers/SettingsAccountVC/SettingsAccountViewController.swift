//
//  SettingsAccountViewController.swift
//  MyMusicApp
//
//  Created by Admin on 15.06.2023.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    var editTitle = UILabel()
    var bacgroundForSettingsView = UIView()
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 36
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = Resources.Colors.brand1.cgColor
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBacground()
        setEditTitle()
        setBackgroundForSettingsView()
        setProfileImage()
        
    }
    
    func setBacground(){
        view.backgroundColor = Resources.Colors.TabBarColors.background
    }
    
    func setEditTitle(){
        view.addSubview(editTitle)
        editTitle.text = "Edit"
        editTitle.font = setFont(nameFont: "Roboto-Medium", sizeFont: 20)
        editTitle.textColor = Resources.Colors.neutral1
        
        editTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(17)
            make.leading.equalToSuperview().inset(173)
        }
    }
    
    func setBackgroundForSettingsView(){
        view.addSubview(bacgroundForSettingsView)
        bacgroundForSettingsView.backgroundColor = Resources.Colors.bacgroundSettings
        bacgroundForSettingsView.layer.cornerRadius = 10
        
        bacgroundForSettingsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(146)
            make.leading.trailing.equalToSuperview().inset(24)
            make.width.equalTo(327)
            make.height.equalTo(496)
        }
    }
    
    func setProfileImage(){
        view.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(142)
            make.bottom.equalTo(bacgroundForSettingsView.snp.bottom).inset(421)
            make.left.equalTo(bacgroundForSettingsView.snp.left).offset(93)
        }
                
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeProfileImage))
        profileImageView.addGestureRecognizer(tapGesture)
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
    
    @objc func changeProfileImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
}




#if DEBUG

import SwiftUI

struct SettingsViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = SettingsViewController

    func makeUIViewController(context: Context) -> UIViewControllerType {
        SettingsViewController(nibName: nil, bundle: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct SettingsViewController_Previews: PreviewProvider {
    static var previews: some View {
        SettingsViewControllerRepresentable()
    }
}

#endif
