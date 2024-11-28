//  SignUpVC.swift
//  LearnConnect
//
//  Created by Ebuzer Şimşek on 21.11.2024.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {
    
    private var viewModel: SignupViewModel!
    
    private let logo: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 12.0
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let createAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Your Account"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "E-posta"
        tf.keyboardType = .emailAddress
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Şifre"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Kayıt Ol", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Zaten Hesabınız Var mı? Giriş Yapın", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignupViewModel()
        
        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
        setupActions()
        setupDismissKeyboardGesture()
        applyTheme()
    }
    
    private func applyTheme() {
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        logo.image = UIImage(named: isDarkMode ? "logo-dark" : "logo")
        overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        updateTextFieldBorders()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateTextFieldBorders()
        }
    }

    private func updateTextFieldBorders() {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        let borderColor: UIColor = isDarkMode ? .white : .clear
        let borderWidth: CGFloat = isDarkMode ? 1.0 : 0.0
        
        [emailTextField, passwordTextField].forEach { textField in
            textField.layer.borderColor = borderColor.cgColor
            textField.layer.borderWidth = borderWidth
            textField.layer.cornerRadius = 8.0
            textField.layer.masksToBounds = true
        }
    }
    
    private func setupViews() {
        view.addSubview(logo)
        view.addSubview(createAccountLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signupButton)
        view.addSubview(signInButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.heightAnchor.constraint(equalToConstant: 180),
            logo.widthAnchor.constraint(equalToConstant: 180),
            
            createAccountLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 15),
            createAccountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            emailTextField.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            signupButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signupButton.heightAnchor.constraint(equalToConstant: 50),
            
            signInButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 15),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupActions() {
        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
    }
    
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func signupTapped() {
        viewModel.email = emailTextField.text
        viewModel.password = passwordTextField.text
        
        viewModel.signupUser { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    let tabBarVC = MainTabBarController()
                    tabBarVC.modalPresentationStyle = .fullScreen
                    self.view.window?.rootViewController = tabBarVC
                    self.view.window?.makeKeyAndVisible()
                }
                
            case .failure(let error):
                self.makeAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    @objc private func signInTapped() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true)
    }
    
    private func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
