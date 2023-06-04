//
//  LoginViewController.swift
//  TelegraphChat
//
//  Created by Berat Ridvan Asilturk 23/05/2023.
//
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                ///Authentication'un  giris yapma kod satiri
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    /// Bir error yok ise ChatViewController'a git komutunu segue'nin identifier'i ile gerceklestirir :
                    self!.performSegue(withIdentifier: Constants.loginSegue, sender: self)
                }
            }
        }
    }
}
