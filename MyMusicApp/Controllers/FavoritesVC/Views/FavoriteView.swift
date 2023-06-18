//
//  FavoriteView.swift
//  MyMusicApp
//
//  Created by Sergey Medvedev on 18.06.2023.
//

import UIKit

class FavoriteView: UIView {
    // MARK: - backButton
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()
    // MARK: - songLabel
    private let songLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SONG"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Bold", size: 20)
        
        return label
    }()
    // MARK: - searchTextField
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = ""
        textField.layer.cornerRadius = 10
        textField.borderStyle = .none
        textField.placeholder = "Search"
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.font = UIFont(name: "Roboto-Regular", size: 18)
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        
        return textField
    }()
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstrains()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - backButtonTapped
    @objc private func backButtonTapped() {
        print("backButtonTapped")
    }
}
extension FavoriteView {
    // MARK: - setupViews
    private func setupViews() {
        
        addSubview(backButton)
        addSubview(songLabel)
        addSubview(searchTextField)
    }
    // MARK: - setConstrains
    private func setConstrains() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
        ])
        NSLayoutConstraint.activate([
            songLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            songLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 130)
        ])
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: songLabel.bottomAnchor, constant: 32),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 24),
            searchTextField.heightAnchor.constraint(equalToConstant: 38)
        ])
        
    }
}
