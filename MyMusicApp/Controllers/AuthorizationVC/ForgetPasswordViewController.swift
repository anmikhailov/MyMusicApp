//
//  ForgetPasswordViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 12.06.2023.
//

import UIKit

class ForgetPasswordViewController: CustomViewController<ForgetPasswordView> {
    
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

extension ForgetPasswordViewController: ForgetPasswordViewDelegate {
    func ForgetPasswordView(_ view: ForgetPasswordView, didTapResetPasswordButton button: UIButton) {
        guard let email = customView.emailText else { return }
        
        if !email.isEmpty {
            FirebaseManager.shared.resetPassword(email: email) { [weak self] err in
                if err == nil {
                    self?.dismiss(animated: true)
                } else {
                    guard let error = err else {return}
                    let errString = String(error.localizedDescription)
                    self?.showAlert(title: "Ooops...", message: errString)
                }
            }
        } else {
            showAlert(title: "Please fill the email", message: nil)
        }
    }
    
    func ForgetPasswordView(_ view: ForgetPasswordView, didTapGoBackButton button: UIButton) {
        self.dismiss(animated: true)
    }
}
