//
//  RegisterViewController.swift
//  TelegraphChat
//
//  Created by Berat Ridvan Asilturk 23/05/2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    private let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {
            return
        }
        viewModel.registerRequest(email: email, password: password) {
            // Bir error yok ise ChatViewController'a git komutunu segue'nin identifier'i ile gerceklestirir :
            self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
        } CompletionFail: {
            print("Register Failed")
        }
    }
}

