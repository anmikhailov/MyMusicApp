//
//  SignInUpView.swift
//  MyMusicApp
//
//  Created by Andrey on 12.06.2023.
//

import UIKit

protocol SignInUpViewDelegate: AnyObject {
    func signInUpView(_ view: SignInUpView, didTapForgotPasswordButton button: UIButton)
    func signInUpView(_ view: SignInUpView, didTapauthRequestButton button: UIButton)
    func signInUpView(_ view: SignInUpView, didTapGoogleAuthButton button: UIButton)
    func signInUpView(_ view: SignInUpView, didTapCreateAccountButton button: UIButton)
}

class SignInUpView: CustomView {
    weak var delegate: SignInUpViewDelegate?
    
    //MARK: - Variables
    lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = Resources.Images.Backgrounds.signIn
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.text = "SIGN UP"
        element.font = UIFont.systemFont(ofSize: 34)
        element.textColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var userDataFieldsVStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 20
        element.distribution = .fill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var userNameTextField: UITextField = {
        let element = UITextField()
        element.layer.cornerRadius = 10
        element.backgroundColor = Resources.Colors.neutral3.withAlphaComponent(0.3)
        
        let imageView = UIImageView(image: Resources.Icons.SignInUp.userName)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        containerView.addSubview(imageView)
        imageView.center = containerView.center
        element.leftView = containerView
        element.leftViewMode = .always

        element.placeholder = "Name"
        element.keyboardType = .default
        element.autocorrectionType = .no
        element.returnKeyType = .done
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var emailTextField: UITextField = {
        let element = UITextField()
        element.layer.cornerRadius = 10
        element.backgroundColor = Resources.Colors.neutral3.withAlphaComponent(0.3)
        
        let imageView = UIImageView(image: Resources.Icons.SignInUp.email)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        containerView.addSubview(imageView)
        imageView.center = containerView.center
        element.leftView = containerView
        element.leftViewMode = .always

        element.placeholder = "E-Mail"
        element.keyboardType = .emailAddress
        element.autocorrectionType = .no
        element.returnKeyType = .done
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
    
    private lazy var forgotPasswordButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = nil
        element.setTitle("Forgot Password?", for: .normal)
        element.setTitleColor(Resources.Colors.neutral1, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapForgotPasswordButton(_:)), for: .touchUpInside)
        return element
    }()
    
    private lazy var authRequestButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = Resources.Colors.brand1
        element.layer.cornerRadius = 10
        element.setTitle("SIGN UP", for: .normal)
        element.setTitleColor(Resources.Colors.neutral3, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapauthRequestButton(_:)), for: .touchUpInside)
        return element
    }()
    
    private lazy var googleAuthLabelHStack: UIStackView = {
        let element = UIStackView()
        element.distribution = .fillEqually
        element.alignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var line1ImageView: UIImageView = {
        let element = UIImageView()
        element.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        element.backgroundColor = Resources.Colors.neutral1
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var googleAuthLabel: UILabel = {
        let element = UILabel()
        element.text = "Or connect with"
        element.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        element.textColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var line2ImageView: UIImageView = {
        let element = UIImageView()
        element.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        element.backgroundColor = Resources.Colors.neutral1
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var googleAuthButton: UIButton = {
        let element = UIButton()
        element.setBackgroundImage(Resources.Icons.SignInUp.googleIcon, for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapGoogleAuthButton(_:)), for: .touchUpInside)
        return element
    }()

    private lazy var createAccountHStack: UIStackView = {
        let element = UIStackView()
        element.spacing = 8
        element.distribution = .fill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var createAccountLabel: UILabel = {
        let element = UILabel()
        element.text = "Already have an account?"
        element.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        element.textColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var createAccountButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = nil
        element.setTitle("Sign In", for: .normal)
        element.setTitleColor(Resources.Colors.brand1, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapCreateAccountButton(_:)), for: .touchUpInside)
        return element
    }()
    
    //MARK: - setViews
    override func setViews() {
        super.setViews()
        
        self.addSubview(backgroundImageView)
        self.addSubview(titleLabel)
        self.addSubview(userDataFieldsVStack)
        self.addSubview(forgotPasswordButton)
        self.addSubview(authRequestButton)
        self.addSubview(googleAuthLabelHStack)
        self.addSubview(googleAuthButton)
        self.addSubview(createAccountHStack)
        
        userDataFieldsVStack.addArrangedSubview(userNameTextField)
        userDataFieldsVStack.addArrangedSubview(emailTextField)
        userDataFieldsVStack.addArrangedSubview(passwordTextField)
        
        googleAuthLabelHStack.addArrangedSubview(line1ImageView)
        googleAuthLabelHStack.addArrangedSubview(googleAuthLabel)
        googleAuthLabelHStack.addArrangedSubview(line2ImageView)
        
        createAccountHStack.addArrangedSubview(createAccountLabel)
        createAccountHStack.addArrangedSubview(createAccountButton)
    }
    
    //MARK: - layoutViews
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 120),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 45),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -45),
            
            userDataFieldsVStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 80),
            userDataFieldsVStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35),
            userDataFieldsVStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
            
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: userDataFieldsVStack.bottomAnchor, constant: 16),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            authRequestButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 30),
            authRequestButton.heightAnchor.constraint(equalToConstant: 50),
            authRequestButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 45),
            authRequestButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -45),
            
            googleAuthLabelHStack.topAnchor.constraint(equalTo: authRequestButton.bottomAnchor, constant: 180),
            googleAuthLabelHStack.heightAnchor.constraint(equalToConstant: 20),
            googleAuthLabelHStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35),
            googleAuthLabelHStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
            
            line1ImageView.heightAnchor.constraint(equalToConstant: 1),
            line2ImageView.heightAnchor.constraint(equalToConstant: 1),
            
            googleAuthButton.topAnchor.constraint(equalTo: googleAuthLabelHStack.bottomAnchor, constant: 25),
            googleAuthButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            createAccountHStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -42),
            createAccountHStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    // Open methods
    func setBGImage(_ image: UIImage?) {
        backgroundImageView.image = image
    }
    
    func setTitleLabel(_ text: String) {
        titleLabel.text = text
    }
    
    func setAuthRequestButtonText(_ text: String) {
        authRequestButton.setTitle(text, for: .normal)
    }
    
    func setCreateAccountLabelText(_ text: String) {
        createAccountLabel.text = text
    }
    
    func setCreateAccountButtonText(_ text: String) {
        createAccountButton.setTitle(text, for: .normal)
    }
    
    func forgotPasswordButtonIsHidden(_ value: Bool) {
        forgotPasswordButton.isHidden = value
    }
    
    func googleAuthViewIsHidden(_ value: Bool) {
        googleAuthLabelHStack.isHidden = value
        googleAuthButton.isHidden = value
    }
}

//MARK: - Target Actions
@objc
private extension SignInUpView {
    
    func didTapCreateAccountButton(_ button: UIButton) {
        delegate?.signInUpView(self, didTapCreateAccountButton: button)
    }
    
    func didTapForgotPasswordButton(_ button: UIButton) {
        delegate?.signInUpView(self, didTapForgotPasswordButton: button)
    }
    
    func didTapauthRequestButton(_ button: UIButton) {
        delegate?.signInUpView(self, didTapauthRequestButton: button)
    }
    
    func didTapGoogleAuthButton(_ button: UIButton) {
        delegate?.signInUpView(self, didTapGoogleAuthButton: button)
    }
    
    func togglePassword(_ button: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
    }
}
