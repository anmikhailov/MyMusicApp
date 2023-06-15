//
//  Welcome.swift
//  MyMusicApp
//
//  Created by Kovs on 15.06.2023.
//

import UIKit
import SnapKit

class Welcome: UIViewController {
    
    let login = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(login)
        login.setTitle("Login", for: .normal)
        login.translatesAutoresizingMaskIntoConstraints = false
        
        login.snp.makeConstraints() { make in
            make.center.equalTo(view)
        }
        
        login.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    // MARK: - SignIn func for UIButton:
    @objc func didTapSignIn() {
        let vc = AuthViewController()
        vc.completionHandler = { [weak self] success in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.handleSignIn(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        // Log user in or show error
        guard success else {
            let alert = UIAlertController(title: "Oops", message: "Something wrong hen signing in..", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
            return
        }
        
        let loggedAppWithTabBar = TabBarController()
        loggedAppWithTabBar.modalPresentationStyle = .fullScreen
        present(loggedAppWithTabBar, animated: true)
    }

}
