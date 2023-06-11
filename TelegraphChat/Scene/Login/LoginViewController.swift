//
//  LoginViewController.swift
//  TelegraphChat
//
//  Created by Berat Ridvan Asilturk 23/05/2023.
//
// [EN]: English comments have been added for foreign companies.

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    private let viewModel = LoginViewModel()
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            // [EN] Func loginRequest in ViewModel is the line of code that CompletionSuccess will do in UI.
            // [TR] ViewModeldeki func loginRequest CompletionSuccess'in uida yapacagi kod satiridir
            viewModel.loginRequest(email: email, password: password) {
                // [EN] If there is no error, it executes the Go to ChatViewController command with the identifier of the segue.
                // [TR] Bir error yok ise ChatViewController'a git komutunu segue'nin identifier'i ile gerceklestirir.
                self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
            // [EN] Func loginRequest in ViewModel is the line of code that CompletionFail will do in UI
            // [TR] ViewModeldeki func loginRequest CompletionFail'in uida yapacagi kod satiridir
            } completionFail: {
                print("Login Request Fail")
            }
        }
    }
    
}
