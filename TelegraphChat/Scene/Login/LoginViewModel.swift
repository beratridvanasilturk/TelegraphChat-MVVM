//
//  LoginViewModel.swift
//  TelegraphChat
//
//  Created by Berat Rıdvan Asiltürk on 4.06.2023.
//

import Foundation
//UIKit'e donusturulmemeli. UI objesi viewmodellerde olmamali. Sebebi UnitTest icerisinde ui objeleri bulunmamalidir.
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


final class LoginViewModel {
    
//    typealias SuccessHandler = (_ success: Bool) -> Void
    typealias VoidHandler = () -> Void
    
    
    func loginRequest(email: String, password: String, completionSuccess: @escaping VoidHandler, completionFail: @escaping VoidHandler) {

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            //Authentication'un  giris yapma kod satiri
            if let e = error {
                print(e.localizedDescription)
                completionFail()
            } else {
                completionSuccess()
            }
        }
    }
}
