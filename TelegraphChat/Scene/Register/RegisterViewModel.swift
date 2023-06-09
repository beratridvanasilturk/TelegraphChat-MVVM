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

class RegisterViewModel {
    
    typealias VoidHandler = () -> Void

    func registerRequest(email: String, password: String, CompletionSuccess: @escaping VoidHandler, CompletionFail: @escaping VoidHandler) {
        // [EN] Trigger code for password authentication.
        // [TR] Password authentication icin firebase register "kayit ol" butonu tetikleme kodu.
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                CompletionFail()
            } else {
                CompletionSuccess()
            }
        }
    }
}
