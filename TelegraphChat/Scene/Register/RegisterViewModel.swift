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


final class RegisterViewModel {
    
    func registerRequest(email: String, password: String, completion: @escaping (Bool) -> Void ) {
        ///Password authentication icin firebase register "kayit ol" butonu tetikleme kodu.
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    
    
}
