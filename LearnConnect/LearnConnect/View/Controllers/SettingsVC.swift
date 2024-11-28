//
//  SettingsVC.swift
//  LearnConnect
//
//  Created by Ebuzer Şimşek on 22.11.2024.
//

import UIKit
import FirebaseAuth
import MessageUI
import StoreKit

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    private var viewModel: SettingsViewModel!
    
    private let darkModeSwitch: UISwitch = {
        let darkSwitch = UISwitch()
        darkSwitch.addTarget(self, action: #selector(darkModeSwitchToggled), for: .valueChanged)
        return darkSwitch
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Kullanıcı Adı"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Çıkış Yap", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SettingsViewModel()
        applyTheme()
        
        view.backgroundColor = .systemBackground
        title = "Ayarlar"
        
        usernameLabel.text = viewModel.username
        darkModeSwitch.isOn = viewModel.darkModeEnabled
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(tableView)
        view.addSubview(signOutButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -20),
            
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signOutButton.widthAnchor.constraint(equalToConstant: 200),
            signOutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.accessoryType = .none
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Karanlık Mod"
            cell.accessoryView = darkModeSwitch
        case 1:
            cell.textLabel?.text = "Bize Ulaşın"
            cell.accessoryType = .disclosureIndicator
        case 2:
            cell.textLabel?.text = "Bizi Oyla"
            cell.accessoryType = .disclosureIndicator
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 1:
            sendMail()
        case 2:
            showRatePopup()
        default:
            break
        }
    }
    
    private func sendMail() {
        viewModel.sendMail { canSend in
            if canSend {
                let mailVC = MFMailComposeViewController()
                mailVC.mailComposeDelegate = self
                mailVC.setToRecipients(["destek@learnconnect.com"])
                mailVC.setSubject("Destek Talebi")
                mailVC.setMessageBody("Merhaba, \n\n", isHTML: false)
                self.present(mailVC, animated: true)
            } else {
                let alert = UIAlertController(title: "Mail Gönderilemiyor", message: "Lütfen cihazınızda bir mail hesabı tanımlayın.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    private func showRatePopup() {
        viewModel.showRatePopup(from: self)
    }
    
    @objc private func darkModeSwitchToggled(_ sender: UISwitch) {
        viewModel.toggleDarkMode(isOn: sender.isOn)
        applyTheme()
    }
    
    private func applyTheme() {
        overrideUserInterfaceStyle = viewModel.darkModeEnabled ? .dark : .light
    }
    
    @objc func signOutTapped() {
        viewModel.signOut { result in
            switch result {
            case .success:
                let loginVC = SignupViewController()
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true, completion: nil)
            case .failure(let error):
                
                let alert = UIAlertController(title: "Çıkış Başarısız", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
}
