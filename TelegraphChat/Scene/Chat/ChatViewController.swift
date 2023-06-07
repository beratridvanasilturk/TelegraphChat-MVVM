//
//  ChatViewController.swift
//  TelegraphChat
//
//  Created by Berat Ridvan Asilturk 23/05/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let dataBase = Firestore.firestore()
    var messages: [Message] = []
    
    private let viewModel = ChatViewModel()
///chatviewmodel icin obje olusturulur
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        ///Login olduktan sonra log out butonuyla cikis yapilabilecegi icin back butonunu bu ekranda islevsiz kalir ve bu kod ile back butonu devre disi birakilir
        title = Constants.appName
        
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        viewModel.loadMessageModel( completion: { succees in
            if succees {
                print("succeed")
            }
        })
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        
        viewModel.logOut(completion: { success in
            if success {
                print("succeed")
                self.navigationController?.popToRootViewController(animated: true)
                ///Sign out basarili oldugunda giris olan kok root ekrana doner, ki bu da bizim karsilama ekranimizdir.
            }
        })
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text, let messageSender =  Auth.auth().currentUser?.email {
            dataBase.collection(Constants.FStore.collectionName).addDocument(data: [ Constants.FStore.senderField: messageSender,
                Constants.FStore.bodyField: messageBody,
                Constants.FStore.dateField: Date().timeIntervalSince1970    ]) { (error) in
                if let e = error {
                    print("Some issues with about saving data to firestore. \(e)")
                } else {
                    print("Succesfully data saved.")
                    
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                    ///Mesaj gonderildikten sonra textfield'i sifirlar
                 
                }
            }
        }
    }
    

}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    ///Mesajlasma kadar table view row'u olusturur
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        /// Sirasiyla mesajlari text'teki label etiketine atar
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            
            cell.messageBuble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: Constants.BrandColors.purple)
            
            // Bu if kod satiri o anki kullanicinin mesajidir
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            
            cell.messageBuble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: Constants.BrandColors.purple)
            
            
        } // Bu else kod satiri diger kullanicinin mesajidir
        
        
     
        return cell
    }
    
    
}


