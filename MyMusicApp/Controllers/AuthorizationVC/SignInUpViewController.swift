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
   
}

//MARK: - SignInUpViewDelegate
extension SignInUpViewController: SignInUpViewDelegate {
   
    func signInUpView(_ view: SignInUpView, didTapForgotPasswordButton button: UIButton) {
        print("Forgot password button tapped")
    }
    
    func signInUpView(_ view: SignInUpView, didTapauthRequestButton button: UIButton) {
        print("AuthRequest button tapped")
    }
    
    func signInUpView(_ view: SignInUpView, didTapGoogleAuthButton button: UIButton) {
        print("GoogleAuth button tapped")
    }
    
    func signInUpView(_ view: SignInUpView, didTapCreateAccountButton button: UIButton) {
        UIView.transition(with: customView.backgroundImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.signUp.toggle()
        }, completion: nil)
    }
}
