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

    override func viewDidLoad() {
        super.viewDidLoad()
        SetBacgroundColors()
        setProfileLabel()

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
