//
//  LoginViewModel.swift
//  TelegraphChat
//
//  Created by Berat Rıdvan Asiltürk on 4.06.2023.
//

import Foundation
///UIKit'e donusturulmemeli. UI objesi viewmodellerde olmamali. Sebebi UnitTest icerisinde ui objeleri bulunmamalidir.
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


final class LoginViewModel {
    
    typealias SuccessHandler = (_ success: Bool) -> Void
    
    func loginRequest(email: String, password: String, completion: @escaping SuccessHandler) {
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            ///Authentication'un  giris yapma kod satiri
            if let e = error {
                print(e.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
