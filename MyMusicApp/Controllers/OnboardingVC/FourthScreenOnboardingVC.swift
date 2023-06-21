//
//  FourthScreenOnboardingVC.swift
//  MyMusicApp
//
//  Created by Марк Райтман on 14.06.2023.
//

import UIKit

class FourthScreenOnboardingVC: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - UI Components
    /// mock image
    private let mockImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "fourth screen back")
        image.alpha = 0.5
        return image
    }()
    
    /// welcome Label
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "YOUR MUSIC, YOUR STYLE"
        label.textColor = .white
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.font = UIFont(name: "Roboto-Bold", size: 28)
        label.textAlignment = .center
        return label
    }()
    
    // comment label
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "Our app allows you to create your own playlists, share your favorite tracks with friends, and explore music recommendations tailored to your unique style. Here, you are the DJ of your life! So let's get started!"
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
        view.backgroundColor = Resources.Colors.brand1
        return view
    }()
    
    /// square dot view #4
    private let dotView4 : UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.brand1
        return view
    }()
    
    /// square dot view #5
    private let dotView5 : UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.brand1
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
        let vc = SignInUpViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension FourthScreenOnboardingVC {
    
    // MARK: - UI Setup
    func setupUI() {
        
        /// ADDING SUBVIEWS
        view?.addSubview(mockImageView)
        view?.addSubview(welcomeLabel)
        view?.addSubview(commentLabel)
        view?.addSubview(dotView1)
        view?.addSubview(dotView2)
        view?.addSubview(dotView3)
        view?.addSubview(dotView4)
        view?.addSubview(dotView5)
        view?.addSubview(getStartedButton)

        /// TAMIC
        mockImageView.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        dotView1.translatesAutoresizingMaskIntoConstraints = false
        dotView2.translatesAutoresizingMaskIntoConstraints = false
        dotView3.translatesAutoresizingMaskIntoConstraints = false
        dotView4.translatesAutoresizingMaskIntoConstraints = false
        dotView5.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false

        /// SETUP CONSTRAINTS
        NSLayoutConstraint.activate([
            mockImageView.topAnchor.constraint(equalTo: view.topAnchor),
            mockImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mockImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mockImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mockImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mockImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
            
            dotView2.centerYAnchor.constraint(equalTo: dotView3.centerYAnchor),
            dotView2.trailingAnchor.constraint(equalTo: dotView3.leadingAnchor, constant: -5),
            dotView2.widthAnchor.constraint(equalToConstant: 5),
            dotView2.heightAnchor.constraint(equalToConstant: 5),
            
            dotView3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dotView3.bottomAnchor.constraint(equalTo: getStartedButton.topAnchor, constant: -25),
            dotView3.widthAnchor.constraint(equalToConstant: 5),
            dotView3.heightAnchor.constraint(equalToConstant: 5),
            
            dotView4.centerYAnchor.constraint(equalTo: dotView3.centerYAnchor),
            dotView4.leadingAnchor.constraint(equalTo: dotView3.trailingAnchor, constant: 5),
            dotView4.widthAnchor.constraint(equalToConstant: 5),
            dotView4.heightAnchor.constraint(equalToConstant: 5),
            
            dotView5.centerYAnchor.constraint(equalTo: dotView4.centerYAnchor),
            dotView5.leadingAnchor.constraint(equalTo: dotView4.trailingAnchor, constant: 5),
            dotView5.widthAnchor.constraint(equalToConstant: 5),
            dotView5.heightAnchor.constraint(equalToConstant: 5),
            
            getStartedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.widthAnchor.constraint(equalToConstant: 280),
            getStartedButton.heightAnchor.constraint(equalToConstant: 50),
        ])

    }
}
