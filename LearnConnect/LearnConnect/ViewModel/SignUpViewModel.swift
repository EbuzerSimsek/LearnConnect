//
//  SignUpViewModel.swift
//  LearnConnect
//
//  Created by Ebuzer Şimşek on 28.11.2024.
//

import Foundation
import FirebaseAuth

class SignupViewModel {
    
    var email: String?
    var password: String?
    
    func validateFields() -> Bool {
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty else {
            return false
        }
        return true
    }
    
    func signupUser(completion: @escaping (Result<Void, Error>) -> Void) {
        guard validateFields() else {
            completion(.failure(SignupError.invalidFields))
            return
        }
        
        Auth.auth().createUser(withEmail: email!, password: password!) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    enum SignupError: Error {
        case invalidFields
    }
}
