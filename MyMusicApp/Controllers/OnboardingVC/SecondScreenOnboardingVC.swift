//
//  SecondScreenOnboardingVC.swift
//  MyMusicApp
//
//  Created by Марк Райтман on 14.06.2023.
//

import UIKit

class SecondScreenOnboardingVC: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - UI Components
    /// mock image
    private let mockImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "second screen back")
        return image
    }()
    
    /// app name Label
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "MyMusicApp"
        label.textColor = Resources.Colors.brand1
        label.backgroundColor = .clear
        label.font = UIFont(name: "Montserrat-Regular", size: 15)
        label.textAlignment = .center
        return label
    }()
    
    // welcome label
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "CUSTOMISE YOUR OWN MUSICAL WAVE"
        label.numberOfLines = 0
        label.font = UIFont(name: "Roboto-Bold", size: 28)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = Resources.Colors.neutral1
        return label
    }()
    
    // comment label
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "With us, you'll find a vast library of tracks and playlists to customize the music specifically to your mood. Create your unique musical wave and dive into an unparalleled audio experience"
        label.numberOfLines = 0
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = Resources.Colors.neutral1
        return label
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
        view.backgroundColor = Resources.Colors.brand1
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
        view.backgroundColor = .clear
        
        setupUI()
        
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    // MARK: - Methods
    @objc func nextScreen(_ sender: UIButton) {
        self.navigationController?.pushViewController(ThirdScreenOnboardingVC(), animated: true)
    }
}

extension SecondScreenOnboardingVC {
    
    // MARK: - UI Setup
    func setupUI() {
        
        /// ADDING SUBVIEWS
        view?.addSubview(mockImageView)
        view?.addSubview(appNameLabel)
        view?.addSubview(welcomeLabel)
        view?.addSubview(commentLabel)
        view?.addSubview(dotView1)
        view?.addSubview(dotView2)
        view?.addSubview(dotView3)
        view?.addSubview(dotView4)
        view?.addSubview(getStartedButton)

        /// TAMIC
        mockImageView.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        dotView1.translatesAutoresizingMaskIntoConstraints = false
        dotView2.translatesAutoresizingMaskIntoConstraints = false
        dotView3.translatesAutoresizingMaskIntoConstraints = false
        dotView4.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false

        /// SETUP CONSTRAINTS
        NSLayoutConstraint.activate([
            mockImageView.topAnchor.constraint(equalTo: view.topAnchor),
            mockImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mockImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mockImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mockImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mockImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            appNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 280),
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appNameLabel.widthAnchor.constraint(equalToConstant: 150),
            appNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            welcomeLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 10),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.75),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 70),
            
            commentLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 10),
            commentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            commentLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.75),
            commentLabel.heightAnchor.constraint(equalToConstant: 120),
            
            dotView1.centerYAnchor.constraint(equalTo: dotView2.centerYAnchor),
            dotView1.trailingAnchor.constraint(equalTo: dotView2.leadingAnchor, constant: -5),
            dotView1.widthAnchor.constraint(equalToConstant: 5),
            dotView1.heightAnchor.constraint(equalToConstant: 5),
            
            dotView2.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 160),
            dotView2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
            
            getStartedButton.bottomAnchor.constraint(equalTo: mockImageView.bottomAnchor, constant: -50),
            getStartedButton.centerXAnchor.constraint(equalTo: mockImageView.centerXAnchor),
            getStartedButton.widthAnchor.constraint(equalToConstant: 280),
            getStartedButton.heightAnchor.constraint(equalToConstant: 50),
        ])

    }
}
