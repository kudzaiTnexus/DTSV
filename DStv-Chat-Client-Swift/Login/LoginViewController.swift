//
//  LoginViewController.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/24.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

class LoginViewController: MainViewController {
    
    private let viewModel = LoginViewModel()
    
    var errorText: String = "" {
        didSet {
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                self.errorLabel.text = self.errorText
                self.errorLabel.center.x += self.view.bounds.width
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        }
    }
    
    // MARK: - View Components
    
    private let logoAvatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.clipsToBounds = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let usernameTextField: UITextField = {
        
        let textField = UITextField(frame: CGRect.zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tintColor = .gray
        textField.backgroundColor = .white
        textField.placeholder = NSLocalizedString("usernamePlaceHolder", comment: "")
        textField.font = .systemFont(ofSize: 20)
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.layer.cornerRadius = 15.0
        textField.layer.borderWidth = 0.2
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.autocapitalizationType = .none
        
        if let icon = UIImage(systemName: "person")  {
            textField.setIcon(icon)
        }
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        
        let textField = UITextField(frame: CGRect.zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tintColor = .gray
        textField.backgroundColor = .white
        textField.placeholder = NSLocalizedString("passwordPlaceHolder", comment: "")
        textField.font = .systemFont(ofSize: 20)
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.layer.cornerRadius = 15.0
        textField.layer.borderWidth = 0.2
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        
        if let icon = UIImage(systemName: "lock")  {
            textField.setIcon(icon)
        }
        
        return textField
    }()
    
    private let loginButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 20
        button.tintColor = .white
        button.backgroundColor = .orange
        button.setTitle(NSLocalizedString("loginButtonTitle", comment: ""), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.3
        button.addTarget(self, action: #selector(onLoginButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private let stackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let errorLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let versionLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .ultraLight)
        label.text = NSLocalizedString("version", comment: "")
        
        return label
    }()
    
    // MARK: - ViewController life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.dismissKeyboard()
        self.usernameTextField.text = ""
        self.passwordTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
}

// MARK: - View setup

extension LoginViewController {
    
    func setupView() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = true
        self.view.addGestureRecognizer(tapGesture)
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        self.stackView.addArrangedSubview(errorLabel)
        self.stackView.addArrangedSubview(usernameTextField)
        self.stackView.addArrangedSubview(passwordTextField)
        self.stackView.setCustomSpacing(25, after: passwordTextField)
        self.stackView.addArrangedSubview(loginButton)
        
        view.addSubview(logoAvatarImage)
        view.addSubview(stackView)
        view.addSubview(versionLabel)
        
        self.setupConstraints()
        
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        logoAvatarImage.translatesAutoresizingMaskIntoConstraints = false
        logoAvatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoAvatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: self.view.frame.size.height/6).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        versionLabel.topAnchor.constraint(equalTo: loginButton.layoutMarginsGuide.topAnchor, constant: 40).isActive = true
        
        usernameTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        
    }
    
    @objc func onLoginButtonTap(sender: UIButton) {
        
        guard NetworkReachability.isInternetAvailable() else {
            self.showErrorAlert(with: NSLocalizedString("offlineTitle", comment: ""),
                                message: NSLocalizedString("offlineMessage", comment: ""))
            return
        }
        
        self.errorText = ""
        
        if self.verifiedInput() {
            
            self.showActivityIndicator()
            
            self.viewModel.signIn(username: usernameTextField.text!,
                                  password: passwordTextField.text!) { (data, error) in
                                    
                                    if let response = data {
                                        
                                        self.hideActivityIndicator()
                                        
                                        guard let name = response.firstName, let guid = response.guid else {
                                            self.hideActivityIndicator()
                                            self.errorText = NSLocalizedString("errorNoDataReceived", comment: "")
                                            return
                                        }
                                        
                                        let friendsViewController =
                                            FriendsTableViewController(with: FriendsRequestParam(name: name,
                                                                                                 uniqueID: guid))
                                        self.navigationController?.pushViewController(friendsViewController,
                                                                                      animated: true)
                                        
                                    } else {
                                        
                                        self.errorText = error!.domain
                                        
                                        self.hideActivityIndicator()
                                        self.usernameTextField.wiggle()
                                        self.passwordTextField.wiggle()
                                        
                                    }
            }
        }
    }
    
    func verifiedInput() -> Bool {
        
        var isValid: Bool = true
        
        guard let username = usernameTextField.text else {
            self.usernameTextField.wiggle()
            isValid = false
            return isValid
        }
        guard let password = passwordTextField.text else {
            self.passwordTextField.wiggle()
            isValid = false
            return isValid
        }
        
        if username.isEmpty {
            self.usernameTextField.wiggle()
            isValid = false
            return isValid
        }
        
        if password.isEmpty {
            self.passwordTextField.wiggle()
            isValid = false
            return isValid
        }
        
        return isValid
    }
}

// MARK: - Handling Keyboard

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/4
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
