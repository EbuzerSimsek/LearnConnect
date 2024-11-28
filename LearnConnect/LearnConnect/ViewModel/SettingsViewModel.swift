//
//  SettingsViewModel.swift
//  LearnConnect
//
//  Created by Ebuzer Şimşek on 28.11.2024.
//

import Foundation
import FirebaseAuth
import MessageUI
import StoreKit

class SettingsViewModel {
    
    
    private(set) var username: String = "Kullanıcı Adı"
    private(set) var darkModeEnabled: Bool
    
    init() {
        
        if let email = Auth.auth().currentUser?.email {
            username = email.components(separatedBy: "@").first ?? "Kullanıcı Adı"
        }
        
        
        darkModeEnabled = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
    
    
    func toggleDarkMode(isOn: Bool) {
        darkModeEnabled = isOn
        UserDefaults.standard.set(isOn, forKey: "isDarkMode")
    }
    
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    
    func sendMail(completion: @escaping (Bool) -> Void) {
        completion(MFMailComposeViewController.canSendMail())
    }
    
    
    func showRatePopup(from viewController: UIViewController) {
        if let scene = viewController.view.window?.windowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
