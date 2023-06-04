//
//  RegisterViewController.swift
//  TelegraphChat
//
//  Created by Berat Ridvan Asilturk 23/05/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
        
        @IBAction func registerPressed(_ sender: UIButton) {
            
            if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                ///Authentication'un kullanici olusturma kod satiri
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    /// Bir error yok ise ChatViewController'a git komutunu segue'nin identifier'i ile gerceklestirir :
                    self!.performSegue(withIdentifier: Constants.registerSegue, sender: self)
                }
            }
            ///Password authentication icin firebase register "kayit ol" butonu tetikleme kodu.
        }
    }
}
