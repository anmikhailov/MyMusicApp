//
//  ChangePasswordView.swift
//  MyMusicApp
//
//  Created by Andrey on 12.06.2023.
//

import UIKit

protocol ChangePasswordViewDelegate: AnyObject {
    func ChangePasswordView(_ view: ChangePasswordView, didTapResetPasswordButton button: UIButton)
    func ChangePasswordView(_ view: ChangePasswordView, didTapGoBackButton button: UIButton)
}

class ChangePasswordView: CustomView {
    weak var delegate: ChangePasswordViewDelegate?
    
    //MARK: - Variables
    
    lazy var goBackButton: UIButton = {
        let element = UIButton()
        element.setBackgroundImage(Resources.Icons.Common.back, for: .normal)
        element.tintColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapGoBackButton(_:)), for: .touchUpInside)
        return element
    }()
    
    lazy var topLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        element.textColor = .white
        element.text = "Forgot Password?"
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var greetingLabel: UILabel = {
        let element = UILabel()
        element.lineBreakMode = .byWordWrapping
        element.numberOfLines = 0
        element.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        element.textColor = Resources.Colors.neutral1
        element.text = "If you need help resetting your password, we can help by sending you a link to reset it."
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var passwordTextField: UITextField = {
        let element = UITextField()
        element.layer.cornerRadius = 10
        element.backgroundColor = Resources.Colors.neutral3.withAlphaComponent(0.3)
        
        let imageView = UIImageView(image: Resources.Icons.SignInUp.password)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        containerView.addSubview(imageView)
        imageView.center = containerView.center
        element.leftView = containerView
        element.leftViewMode = .always
        
        let button = UIButton(type: .custom)
        button.setImage(Resources.Icons.SignInUp.showPassword, for: .normal)
        button.tintColor = Resources.Colors.neutral1
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.addTarget(self, action: #selector(togglePassword(_:)), for: .touchUpInside)
        let containerViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
        containerViewRight.addSubview(button)
        button.center = containerViewRight.center
        
        element.rightView = containerViewRight
        element.rightViewMode = .always
        
        element.placeholder = "Password"
        element.autocorrectionType = .no
        element.isSecureTextEntry = true
        element.returnKeyType = .done
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var repeatPasswordTextField: UITextField = {
        let element = UITextField()
        element.layer.cornerRadius = 10
        element.backgroundColor = Resources.Colors.neutral3.withAlphaComponent(0.3)
        
        let imageView = UIImageView(image: Resources.Icons.SignInUp.password)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        containerView.addSubview(imageView)
        imageView.center = containerView.center
        element.leftView = containerView
        element.leftViewMode = .always
        
        let button = UIButton(type: .custom)
        button.setImage(Resources.Icons.SignInUp.showPassword, for: .normal)
        button.tintColor = Resources.Colors.neutral1
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.addTarget(self, action: #selector(toggleRepeatPassword(_:)), for: .touchUpInside)
        let containerViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
        containerViewRight.addSubview(button)
        button.center = containerViewRight.center
        
        element.rightView = containerViewRight
        element.rightViewMode = .always
        
        element.placeholder = "Confirm Password"
        element.autocorrectionType = .no
        element.isSecureTextEntry = true
        element.returnKeyType = .done
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    lazy var resetPasswordButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = Resources.Colors.brand1
        element.setTitleColor(Resources.Colors.neutral3, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        element.setTitle("CHANGE PASSWORD", for: .normal)
        element.layer.cornerRadius = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapResetPasswordButton(_:)), for: .touchUpInside)
        return element
    }()

    var passwordText: String? {
        return passwordTextField.text
    }
    
    var repeatPasswordText: String? {
        return repeatPasswordTextField.text
    }
    
    //MARK: - setViews
    override func setViews() {
        super.setViews()
        self.backgroundColor = Resources.Colors.brand2
        
        self.addSubview(goBackButton)
        self.addSubview(topLabel)
        self.addSubview(greetingLabel)
        self.addSubview(passwordTextField)
        self.addSubview(repeatPasswordTextField)
        self.addSubview(resetPasswordButton)
    }
    
    //MARK: - layoutViews
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            goBackButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            goBackButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            
            topLabel.topAnchor.constraint(equalTo: goBackButton.bottomAnchor, constant: 30),
            topLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            
            greetingLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 25),
            greetingLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            greetingLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -100),
       
            passwordTextField.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55),
            passwordTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 55),
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -40),
      
            resetPasswordButton.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 40),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 55),
            resetPasswordButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            resetPasswordButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -40),
        ])
    }
}

//MARK: - Target Actions
@objc
private extension ChangePasswordView {
    func didTapResetPasswordButton(_ button: UIButton) {
        delegate?.ChangePasswordView(self, didTapResetPasswordButton: button)
    }
    
    func didTapGoBackButton(_ button: UIButton) {
        delegate?.ChangePasswordView(self, didTapGoBackButton: button)
    }
    
    func togglePassword(_ button: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    func toggleRepeatPassword(_ button: UIButton) {
        repeatPasswordTextField.isSecureTextEntry.toggle()
    }
}
