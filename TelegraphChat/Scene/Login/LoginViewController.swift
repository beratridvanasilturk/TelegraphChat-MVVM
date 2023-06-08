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
            
            
            
            viewModel.loginRequest(email: email, password: password) {
                // ViewModeldeki func loginRequest CompletionSuccess'in uida yapacagi kod satiridir
                // Bir error yok ise ChatViewController'a git komutunu segue'nin identifier'i ile gerceklestirir :
                self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
            } completionFail: {
                // ViewModeldeki func loginRequest CompletionFail'in uida yapacagi kod satiridir
                print("gg")
            }
        }
    }
    
}
