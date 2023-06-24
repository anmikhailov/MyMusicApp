//
//  FirstScreenOnboardingVC.swift
//  MyMusicApp
//
//  Created by Марк Райтман on 14.06.2023.
//

import UIKit
import UserNotifications

class FirstScreenOnboardingVC: UIViewController {
    
    // MARK: - UI Components
    /// mock image
    private let mockImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "first screen back")
        return image
    }()
    
    /// square dot view #1
    private let dotView1 : UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.brand1
        return view
    }()
    
    /// square dot view #2
    private let dotView2 : UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.neutral2
        return view
    }()
    
    /// square dot view #3
    private let dotView3 : UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.neutral2
        return view
    }()
    
    /// square dot view #4
    private let dotView4 : UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.neutral2
        return view
    }()
    
    /// app name Label
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "MyMusicApp"
        label.textColor = Resources.Colors.brand1
        label.backgroundColor = .clear
        label.font = UIFont(name: "Montserrat-Regular", size: 15)
        label.textAlignment = .left
        return label
    }()
    
    // welcome label
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "WELCOME TO \nTHE MUSIC JOURNEY!"
        label.numberOfLines = 0
        label.font = UIFont(name: "Roboto-Bold", size: 28)
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.textColor = Resources.Colors.neutral1
        return label
    }()
    
    // comment label
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "Open the doors to an infinite world of sounds and get ready for an unforgettable musical journey with our app. Immerse yourself in music that inspires and brings joy"
        label.numberOfLines = 0
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.textColor = Resources.Colors.neutral1
        return label
    }()
    
    /// get started button
    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.configuration?.title = "GET STARTED"
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
        button.titleLabel?.textAlignment = .center
        button.configuration?.baseForegroundColor = Resources.Colors.neutral3
        button.configuration?.baseBackgroundColor = Resources.Colors.brand1
        button.configuration?.cornerStyle = .medium
        button.addTarget(self, action: #selector(nextScreen(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        view.backgroundColor = .black
        
        setupUI()
    }
    
    // MARK: - Methods
    @objc private func nextScreen(_ sender: UIButton) {
        self.navigationController?.pushViewController(SecondScreenOnboardingVC(), animated: true)
    }
}

extension FirstScreenOnboardingVC {
    
    // MARK: - UI Setup
    func setupUI() {
        
        /// ADDING SUBVIEWS
        view?.addSubview(mockImageView)
        view?.addSubview(dotView1)
        view?.addSubview(dotView2)
        view?.addSubview(dotView3)
        view?.addSubview(dotView4)
        view?.addSubview(appNameLabel)
        view?.addSubview(welcomeLabel)
        view?.addSubview(commentLabel)
        view?.addSubview(getStartedButton)
        
        /// TAMIC
        mockImageView.translatesAutoresizingMaskIntoConstraints = false
        dotView1.translatesAutoresizingMaskIntoConstraints = false
        dotView2.translatesAutoresizingMaskIntoConstraints = false
        dotView3.translatesAutoresizingMaskIntoConstraints = false
        dotView4.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        
        /// SETUP CONSTRAINTS
        NSLayoutConstraint.activate([
            mockImageView.topAnchor.constraint(equalTo: view.topAnchor),
            mockImageView.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: view.bottomAnchor, multiplier: 0.5),
            mockImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mockImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mockImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dotView1.topAnchor.constraint(equalTo: mockImageView.bottomAnchor, constant: 60),
            dotView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            dotView1.widthAnchor.constraint(equalToConstant: 5),
            dotView1.heightAnchor.constraint(equalToConstant: 5),
            
            dotView2.centerYAnchor.constraint(equalTo: dotView1.centerYAnchor),
            dotView2.leadingAnchor.constraint(equalTo: dotView1.trailingAnchor, constant: 5),
            dotView2.widthAnchor.constraint(equalToConstant: 5),
            dotView2.heightAnchor.constraint(equalToConstant: 5),
            
            dotView3.centerYAnchor.constraint(equalTo: dotView2.centerYAnchor),
            dotView3.leadingAnchor.constraint(equalTo: dotView2.trailingAnchor, constant: 5),
            dotView3.widthAnchor.constraint(equalToConstant: 5),
            dotView3.heightAnchor.constraint(equalToConstant: 5),
            
            dotView4.centerYAnchor.constraint(equalTo: dotView3.centerYAnchor),
            dotView4.leadingAnchor.constraint(equalTo: dotView3.trailingAnchor, constant: 5),
            dotView4.widthAnchor.constraint(equalToConstant: 5),
            dotView4.heightAnchor.constraint(equalToConstant: 5),
            
            appNameLabel.topAnchor.constraint(equalTo: dotView1.bottomAnchor, constant: 50),
            appNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            appNameLabel.widthAnchor.constraint(equalToConstant: 150),
            appNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            welcomeLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 10),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            welcomeLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.75),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 70),
            
            commentLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 5),
            commentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            commentLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.75),
            commentLabel.heightAnchor.constraint(equalToConstant: 100),
            
            getStartedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.widthAnchor.constraint(equalToConstant: 280),
            getStartedButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
