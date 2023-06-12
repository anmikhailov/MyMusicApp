//
//  ChangePasswordViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 12.06.2023.
//

import UIKit

class ChangePasswordViewController: CustomViewController<ChangePasswordView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
    }
    
    func showAlert(title: String, message: String?) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alertController, animated: true)
    }
}

extension ChangePasswordViewController: ChangePasswordViewDelegate {
    func ChangePasswordView(_ view: ChangePasswordView, didTapResetPasswordButton button: UIButton) {
        guard let password = customView.passwordText else { return }
        guard let repeatPassword = customView.repeatPasswordText else { return }
        
        if !password.isEmpty && !repeatPassword.isEmpty {
            if password == repeatPassword {
                print("Change Password ...")
                // Firebase method
            }
        } else {
            showAlert(title: "Please fill all fields", message: nil)
        }
    }
    
    func ChangePasswordView(_ view: ChangePasswordView, didTapGoBackButton button: UIButton) {
        self.dismiss(animated: true)
    }
}
