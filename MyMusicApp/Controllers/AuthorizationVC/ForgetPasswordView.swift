//
//  ForgetPasswordView.swift
//  MyMusicApp
//
//  Created by Andrey on 12.06.2023.
//

import UIKit

protocol ForgetPasswordViewDelegate: AnyObject {
    func ForgetPasswordView(_ view: ForgetPasswordView, didTapResetPasswordButton button: UIButton)
    func ForgetPasswordView(_ view: ForgetPasswordView, didTapGoBackButton button: UIButton)
}

class ForgetPasswordView: CustomView {
    weak var delegate: ForgetPasswordViewDelegate?
    
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
    
    lazy var emailTextField: UITextField = {
        let element = UITextField()
        element.layer.cornerRadius = 12
        element.backgroundColor = Resources.Colors.neutral1.withAlphaComponent(0.1)
        
        let imageView = UIImageView(image: Resources.Icons.SignInUp.email)
        imageView.tintColor = Resources.Colors.neutral1
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        containerView.addSubview(imageView)
        imageView.center = containerView.center
        element.leftView = containerView
        element.leftViewMode = .always

        element.placeholder = "E-Mail"
        element.keyboardType = .emailAddress
        element.autocorrectionType = .no
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    lazy var resetPasswordButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = Resources.Colors.brand1
        element.setTitleColor(Resources.Colors.neutral3, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        element.setTitle("SENT", for: .normal)
        element.layer.cornerRadius = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapResetPasswordButton(_:)), for: .touchUpInside)
        return element
    }()

    var emailText: String? {
        return emailTextField.text
    }
    
    //MARK: - setViews
    override func setViews() {
        super.setViews()
        self.backgroundColor = Resources.Colors.brand2
        
        self.addSubview(goBackButton)
        self.addSubview(topLabel)
        self.addSubview(greetingLabel)
        self.addSubview(emailTextField)
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
       
            emailTextField.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 30),
            emailTextField.heightAnchor.constraint(equalToConstant: 55),
            emailTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -40),
      
            resetPasswordButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 55),
            resetPasswordButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            resetPasswordButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -40),
        ])
    }
}

//MARK: - Target Actions
private extension ForgetPasswordView {
    @objc func didTapResetPasswordButton(_ button: UIButton) {
        delegate?.ForgetPasswordView(self, didTapResetPasswordButton: button)
    }
    
    @objc func didTapGoBackButton(_ button: UIButton) {
        delegate?.ForgetPasswordView(self, didTapGoBackButton: button)
    }
}
