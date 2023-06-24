//
//  SettingsAccountViewController.swift
//  MyMusicApp
//
//  Created by Admin on 15.06.2023.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    var editTitle = UILabel()
    var bacgroundForSettingsView = UIView()
    var cameraImageView = UIImageView()
    var usernanameLabel = UILabel()
    var emailLabel = UILabel()
    var dateOfBirthLabel = UILabel()
    var userNameTextField = UITextField()
    var emailTextField = UITextField()
    var dateOfBirthDatePicker = UIDatePicker()
    var changePasswordButton = UIButton(type: .system)
    let backButton = UIButton(type: .system)
    var userInfo:UserInfo?
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 70
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = Resources.Colors.brand1.cgColor
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .white
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfo = FirebaseManager.shared.getFromUserDefaultsUserInfo()
        
        setBacground()
        setEditTitle()
        setBackgroundForSettingsView()
        setProfileImage()
        setCameraImageViev()
        setLabel()
        setChangePasswordButton()
        setUserNameTextField()
        setEmailTextField()
        setDateOfBirthDatePicker()
        setBackButton()
        
    }
//MARK: - Func
    func setBacground(){
        view.backgroundColor = Resources.Colors.TabBarColors.background
    }
    
    func setEditTitle(){
        view.addSubview(editTitle)
        editTitle.text = "Edit"
        editTitle.font = setFont(nameFont: "Roboto-Medium", sizeFont: 20)
        editTitle.textColor = Resources.Colors.neutral1
        
        editTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(17)
            make.leading.equalToSuperview().inset(173)
        }
    }
    
    func setBackgroundForSettingsView(){
        view.addSubview(bacgroundForSettingsView)
        bacgroundForSettingsView.backgroundColor = Resources.Colors.bacgroundSettings
        bacgroundForSettingsView.layer.cornerRadius = 10
        
        bacgroundForSettingsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(146)
            make.leading.trailing.equalToSuperview().inset(24)
            make.width.equalTo(327)
            make.height.equalTo(496)
        }
    }
    
    func setProfileImage(){
        view.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(142)
            make.bottom.equalTo(bacgroundForSettingsView.snp.bottom).inset(421)
            make.left.equalTo(bacgroundForSettingsView.snp.left).offset(93)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeProfileImage))
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    func setCameraImageViev(){
        let cameraView = UIView()
        view.addSubview(cameraView)
        cameraView.backgroundColor = Resources.Colors.brand1
        cameraView.layer.cornerRadius = 20
        
        view.addSubview(cameraImageView)
        cameraImageView.image = UIImage(systemName: "camera.fill")
        cameraImageView.tintColor = .black
        
        cameraView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top).inset(102)
            make.leading.equalTo(profileImageView.snp.leading).inset(102)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.center.equalTo(cameraView)
        }
    }
    
    func setLabel(){
        view.addSubview(usernanameLabel)
        view.addSubview(emailLabel)
        view.addSubview(dateOfBirthLabel)
        
        usernanameLabel.text = "Username"
        emailLabel.text = "Email"
        dateOfBirthLabel.text = "Date of birth"
        
        usernanameLabel.font = setFont(nameFont: "Roboto-Medium", sizeFont: 14)
        emailLabel.font = setFont(nameFont: "Roboto-Medium", sizeFont: 14)
        dateOfBirthLabel.font = setFont(nameFont: "Roboto-Medium", sizeFont: 14)
        
        usernanameLabel.textColor = Resources.Colors.TabBarColors.inactive
        emailLabel.textColor = Resources.Colors.TabBarColors.inactive
        dateOfBirthLabel.textColor = Resources.Colors.TabBarColors.inactive
        
        usernanameLabel.snp.makeConstraints { make in
            make.top.equalTo(bacgroundForSettingsView.snp.top).inset(165)
            make.leading.equalTo(bacgroundForSettingsView.snp.leading).inset(16)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(usernanameLabel.snp.bottom).offset(52)
            make.leading.equalTo(bacgroundForSettingsView.snp.leading).inset(16)
        }
        
        dateOfBirthLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(52)
            make.leading.equalTo(bacgroundForSettingsView.snp.leading).inset(16)
        }
    }
    
    func setChangePasswordButton(){
        view.addSubview(changePasswordButton)
        changePasswordButton.setTitle("Change password", for: .normal)
        changePasswordButton.tintColor = Resources.Colors.brand1
        
        changePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(bacgroundForSettingsView.snp.bottom).offset(45)
            make.centerX.equalToSuperview()
        }
        
        changePasswordButton.addTarget(self, action: #selector(changePasswordTapped), for: .touchUpInside)
        
    }
    
    
    
    func setUserNameTextField(){
        view.addSubview(userNameTextField)
        userNameTextField.returnKeyType = .done
        userNameTextField.autocapitalizationType = .words
        userNameTextField.autocorrectionType = .no
        userNameTextField.resignFirstResponder()
        userNameTextField.textAlignment = .right
        userNameTextField.delegate = self
        userNameTextField.text = userInfo?.name
        userNameTextField.font = setFont(nameFont: "Roboto-Medium", sizeFont: 15)
        
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(usernanameLabel.snp.top)
            make.leading.equalTo(usernanameLabel.snp.trailing).offset(10)
            make.trailing.equalTo(bacgroundForSettingsView.snp.trailing).inset(16)
        }
    }
    
    func setEmailTextField(){
        view.addSubview(emailTextField)
        emailTextField.returnKeyType = .done
        emailTextField.autocapitalizationType = .words
        emailTextField.autocorrectionType = .no
        emailTextField.resignFirstResponder()
        emailTextField.textAlignment = .right
        emailTextField.delegate = self
        emailTextField.text = userInfo?.email
        emailTextField.font = setFont(nameFont: "Roboto-Medium", sizeFont: 15)
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.top)
            make.leading.equalTo(emailLabel.snp.trailing).offset(10)
            make.trailing.equalTo(bacgroundForSettingsView.snp.trailing).inset(16)
        }
    }
    
    func setDateOfBirthDatePicker(){
        dateOfBirthDatePicker.tintColor = Resources.Colors.TabBarColors.background
        view.addSubview(dateOfBirthDatePicker)
        dateOfBirthDatePicker.datePickerMode = .date
        dateOfBirthDatePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        dateOfBirthDatePicker.snp.makeConstraints { make in
            make.centerY.equalTo(dateOfBirthLabel.snp.top)
            make.leading.equalTo(dateOfBirthLabel.snp.trailing).offset(130)
            make.trailing.equalTo(bacgroundForSettingsView.snp.trailing).inset(16)
        }
    }
    
    func setBackButton(){
        view.addSubview(backButton)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(editTitle.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    func setFont(nameFont:String, sizeFont:CGFloat) -> UIFont {
        if let customFont = UIFont(name: nameFont, size: sizeFont){
            return customFont
        }
        else{
            print("Eror Font")
            fatalError("Eror Font")
        }
    }
    
//MARK: - @OBJC Func
    
    @objc func changeProfileImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let selectedDate = dateFormatter.string(from: dateOfBirthDatePicker.date)
        print("\(selectedDate)")
    }
    
    @objc func changePasswordTapped(){
        let changePasswordVC = ChangePasswordViewController()
        changePasswordVC.modalPresentationStyle = .fullScreen
        self.present(changePasswordVC, animated: true)
    }
    
    @objc func backButtonTapped() {
        let email = emailTextField.text ?? ""
        let nameUser = userNameTextField.text ?? ""
        
        FirebaseManager.shared.changeProfileInfo(email: email, name: nameUser) { _ in
            
        }
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Extension

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let text = textField.text
        return true
    }
}


//MARK: - Preview

#if DEBUG

import SwiftUI

struct SettingsViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = SettingsViewController

    func makeUIViewController(context: Context) -> UIViewControllerType {
        SettingsViewController(nibName: nil, bundle: nil)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
}

struct SettingsViewController_Previews: PreviewProvider {
    static var previews: some View {
        SettingsViewControllerRepresentable()
    }
}

#endif
