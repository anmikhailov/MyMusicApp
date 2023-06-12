//
//  SignInUpViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 12.06.2023.
//

import UIKit

class SignInUpViewController: CustomViewController<SignInUpView> {
    
    var signUp: Bool = true {
        willSet {
            if newValue {
                customView.setBGImage(Resources.Images.Backgrounds.signUp)
                customView.setTitleLabel("SIGN UP")
                customView.userNameTextField.isHidden = false
                customView.forgotPasswordButtonIsHidden(true)
                customView.setAuthRequestButtonText("SIGN UP")
                customView.googleAuthViewIsHidden(true)
                customView.setCreateAccountLabelText("Already have an account?")
                customView.setCreateAccountButtonText("Sign In")
            } else {
                customView.setBGImage(Resources.Images.Backgrounds.signIn)
                customView.setTitleLabel("SIGN IN")
                customView.userNameTextField.isHidden = true
                customView.forgotPasswordButtonIsHidden(false)
                customView.setAuthRequestButtonText("SIGN IN")
                customView.googleAuthViewIsHidden(false)
                customView.setCreateAccountLabelText("Don't have an account?")
                customView.setCreateAccountButtonText("Sign Up")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        
        signUp = false
        
    }
   
    func showAlert(title: String, message: String?) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alertController, animated: true)
    }
}

//MARK: - SignInUpViewDelegate
extension SignInUpViewController: SignInUpViewDelegate {
   
    func signInUpView(_ view: SignInUpView, didTapForgotPasswordButton button: UIButton) {
        print("Forgot password button tapped")
    }
    
    func signInUpView(_ view: SignInUpView, didTapauthRequestButton button: UIButton) {
        guard let username = customView.userNameTextField.text else { return }
        guard let email = customView.emailTextField.text else { return }
        guard let password = customView.passwordTextField.text else { return }
        
        if signUp {
            if !username.isEmpty && !email.isEmpty && !password.isEmpty {
                FirebaseManager.shared.createAccount(email: email, password: password, username: username) { err in
                    if err == nil {
                        //                            let categoriesVC = CategoriesViewController(isFirstEnter: true)
                        //                            categoriesVC.modalPresentationStyle = .fullScreen
                        //                            self.present(categoriesVC, animated: true)
                        print("Registration ok")
                    } else {
                        guard let error = err else {return}
                        let errString = String(error.localizedDescription)
                        self.showAlert(title: "Ooops...", message: errString)
                    }
                }
            } else {
                showAlert(title: "Please fill out all fields", message: nil)
            }
        } else {
            if !email.isEmpty && !password.isEmpty {
                FirebaseManager.shared.signIn(email: email, password: password) { error in
                    if error == nil {
//                        let tabBarController = TabBarController()
//                        tabBarController.modalPresentationStyle = .fullScreen
//                        self.present(tabBarController, animated: true)
                        print("Auth ok")
                    } else {
                        guard let error = error else {return}
                        let errString = String(error.localizedDescription)
                        self.showAlert(title: "Ooops...", message: errString)
                    }
                }
            } else {
                showAlert(title: "Please fill out all fields", message: nil)
            }
        }
    }
    
    func signInUpView(_ view: SignInUpView, didTapGoogleAuthButton button: UIButton) {
        FirebaseManager.shared.googleAuth(withPresenting: self) { err in
            if err == nil {
//                let tabBarController = TabBarController()
//                tabBarController.modalPresentationStyle = .fullScreen
//                self.present(tabBarController, animated: true)
                print("Google auth ok")
            } else {
                guard let error = err else {return}
                let errString = String(error.localizedDescription)
                self.showAlert(title: "Ooops...", message: errString)
            }
        }
    }
    
    func signInUpView(_ view: SignInUpView, didTapCreateAccountButton button: UIButton) {
        UIView.transition(with: customView.backgroundImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.signUp.toggle()
        }, completion: nil)
    }
}
