//
//  LoginViewController.swift
//  TelegraphChat
//
//  Created by Berat Ridvan Asilturk 23/05/2023.
//
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    private let viewModel = LoginViewModel()
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
        
            // ViewModeldeki func loginRequest CompletionSuccess'in uida yapacagi kod satiridir
            viewModel.loginRequest(email: email, password: password) {
                // Bir error yok ise ChatViewController'a git komutunu segue'nin identifier'i ile gerceklestirir :
                self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
            // ViewModeldeki func loginRequest CompletionFail'in uida yapacagi kod satiridir
            } completionFail: {
                print("Login Request Fail")
            }
        }
    }
    
}
