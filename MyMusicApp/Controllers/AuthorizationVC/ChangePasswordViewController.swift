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
                FirebaseManager.shared.changePassword(password: password) { error in
                    if error == nil {
                        self.showAlert(title: "Password changed", message: "")
                    } else {
                        guard let error = error else {return}
                        let errString = String(error.localizedDescription)
                        self.showAlert(title: "Ooops...", message: errString)
                    }
                }
            }
        } else {
            showAlert(title: "Please fill all fields", message: nil)
        }
    }
    
    func ChangePasswordView(_ view: ChangePasswordView, didTapGoBackButton button: UIButton) {
        self.dismiss(animated: true)
    }
}
