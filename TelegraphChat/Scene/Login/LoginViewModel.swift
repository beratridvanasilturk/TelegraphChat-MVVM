//
//  LoginViewModel.swift
//  TelegraphChat
//
//  Created by Berat Rıdvan Asiltürk on 4.06.2023.
//
// [EN]: English comments have been added for foreign companies.

import Foundation
// [EN] Foundation should never be converted to UIKit in the model section of the MVVM.
// [TR] Foundation UIKit'e donusturulmemeli. UI objesi viewmodellerde olmamali. Sebebi UnitTest icerisinde ui objeleri bulunmamalidir.
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

final class LoginViewModel {
    
    typealias VoidHandler = () -> Void
    
    func loginRequest(email: String, password: String, completionSuccess: @escaping VoidHandler, completionFail: @escaping VoidHandler) {
        // [EN] Authentication's login code line.
        // [TR] Authentication'un  giris yapma kod satiri
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let e = error {
                print(e.localizedDescription)
                completionFail()
            } else {
                completionSuccess()
            }
        }
    }
}
