//
//  File.swift
//  TelegraphChat
//
//  Created by Berat Rıdvan Asiltürk on 4.06.2023.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

protocol RegisterViewModelDelegate: AnyObject {
    func didSuccess()
    func didFail(error: Error)
}

extension RegisterViewModelDelegate {
    func didFail(error: Error) {
        print(error.localizedDescription)
    }
}

final class RegisterViewModel {
    
    weak var delegate: RegisterViewModelDelegate?
    
    func registerRequest(email: String, password: String) {
        ///Password authentication icin firebase register "kayit ol" butonu tetikleme kodu.
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.delegate?.didFail(error: error)
            } else {
                self?.delegate?.didSuccess()
            }
        }
    }
    
    
    
}
