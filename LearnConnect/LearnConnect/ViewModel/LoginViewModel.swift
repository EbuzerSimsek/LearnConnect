//
//  SignInViewModel.swift
//  LearnConnect
//
//  Created by Ebuzer Şimşek on 28.11.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class LoginViewModel {
    var email: String = ""
    var password: String = ""
    
    var isDarkMode: Bool {
        return UserDefaults.standard.bool(forKey: "isDarkMode")
    }

    func login(completion: @escaping (Result<Void, Error>) -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            completion(.failure(LoginError.emptyFields))
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.createUserInFirestore { result in
                    completion(result)
                }
            }
        }
    }
    
    private func createUserInFirestore(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(.failure(LoginError.userNotFound))
            return
        }
        
        let db = Firestore.firestore()
        db.collection("Users").document(userID).setData(["enrolledCourses": []]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    enum LoginError: Error {
        case emptyFields
        case userNotFound
    }
}
