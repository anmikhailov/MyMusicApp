//
//  SettingsAccountViewController.swift
//  MyMusicApp
//
//  Created by Admin on 15.06.2023.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class SettingsViewController: UIViewController, UINavigationControllerDelegate{
    
    // MARK: - Properties
    //create a reference to user id
    let uid = FirebaseManager.shared.userUid
    
    //create a reference to Firestore db
    let db = Firestore.firestore()
    
    //MARK: - UI Components
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
    let userDefaults = UserDefaults.standard
    let imageData = Data()
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
        
        retrievePhoto()
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
            make.centerX.equalToSuperview()
        }
    }
    
    func setBackgroundForSettingsView(){
        view.addSubview(bacgroundForSettingsView)
        bacgroundForSettingsView.backgroundColor = Resources.Colors.bacgroundSettings
        bacgroundForSettingsView.layer.cornerRadius = 10
        
        bacgroundForSettingsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(146)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(133)
            make.leading.trailing.equalToSuperview().inset(24)
            make.width.equalTo(327)
//            make.height.equalTo(496)
        }
    }
    
    func setProfileImage(){
        view.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(142)
            make.top.equalTo(bacgroundForSettingsView.snp.top).offset(-72)
            make.centerX.equalTo(bacgroundForSettingsView)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageButtonTapped))
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func profileImageButtonTapped() {
        showImagePickerControllerActionSheets()
    }
    
//    func loadProfileImage() {
//        if let profileImageData = UserDefaults.standard.data(forKey: "profileImage"),
//           let profileImage = UIImage(data: profileImageData) {
//            profileImageView.image = profileImage
//        }
//    }
//
//    func saveProfileImage(_ image: UIImage) {
//        if let imageData = image.jpegData(compressionQuality: 1.0) {
//            UserDefaults.standard.set(imageData, forKey: "profileImage")
//        }
//    }
    
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
        view.addSubview(dateOfBirthDatePicker)
        dateOfBirthDatePicker.tintColor = Resources.Colors.brand1
        dateOfBirthDatePicker.datePickerMode = .date
        dateOfBirthDatePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let currentDate = Date()
        let fourteenYearsAgo = Calendar.current.date(byAdding: .year, value: -14, to: currentDate)
        let hundredYearsAgo = Calendar.current.date(byAdding: .year, value: -100, to: currentDate)
        dateOfBirthDatePicker.minimumDate = hundredYearsAgo
        dateOfBirthDatePicker.maximumDate = fourteenYearsAgo
                
        if let savedDate = userDefaults.object(forKey: "selectedDate") as? Date {
            dateOfBirthDatePicker.date = savedDate
            dateChanged()
        }

        
        dateOfBirthDatePicker.snp.makeConstraints { make in
            make.top.equalTo(dateOfBirthLabel.snp.top).inset(-9)
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
    
    private func uploadPhoto(with selectedImage: UIImage?) {
        
        //make sure that image property isn't nill
        guard selectedImage != nil else { return }
        
        //create storage reference
        let storageRef = Storage.storage().reference()
        
        //turn our image into data
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
        
        //check that we were able to convert it to data
        guard imageData != nil else { return }
        
        //specify the file path and name
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        //upload the data to dt
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            
            //check fore errors
            if error == nil && metadata != nil {
                
                //save a reference to the file in Firestore db
                self.db.collection("users").document(self.uid).setData(["url" : path], merge: true)
                
                //            db.collection("users").document(uid).setData([ "userImage": "\(editedImage)" ], merge: true)
            }
        }
    }
    
    private func retrievePhoto() {
        //get the data from db
        db.collection("users").getDocuments { snapshot, error in
            if error == nil && snapshot != nil {
                var paths = [String]()
                
                //loop through all the returned docs
                for doc in snapshot!.documents {
                    
                    //extract file path and add to array
                    paths.append(doc["url"] as? String ?? "")
                    
                    for path in paths {
                        
                        let storageRef = Storage.storage().reference()
                        
                        let fileRef = storageRef.child(path)
                        
                        fileRef.getData(maxSize: 5*1024*1024) { data, error in
                            if error == nil && data != nil {
                                
                                let image = UIImage(data: data!)
                                
                                DispatchQueue.main.async {
                                    self.profileImageView.image = image
                                }
                            }
                        }
                    }
                }
            }
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
        let selectedDate = dateOfBirthDatePicker.date
//        let formattedDate = dateFormatter.string(from: selectedDate)
        userDefaults.set(selectedDate, forKey: "selectedDate")
        
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
//        textField.resignFirstResponder()
//        let text = textField.text
        return true
    }
}

//extension SettingsViewController: UIImagePickerControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//            profileImageView.image = editedImage
//            saveProfileImage(editedImage)
//        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            profileImageView.image = originalImage
//        }
//        dismiss(animated: true, completion: nil)
//    }
//}

extension SettingsViewController: UIImagePickerControllerDelegate {
    
    func showImagePickerControllerActionSheets() {
        let photoLibraryAction = UIAlertAction(title: "Choose from Library", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Take a Photo", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        AlertService.showAlert(style: .actionSheet, title: "Choose your image", message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImageView.image = editedImage
            uploadPhoto(with: profileImageView.image)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.image = originalImage
            uploadPhoto(with: profileImageView.image)
        }
        dismiss(animated: true, completion: nil)
    }
}
