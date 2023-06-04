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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        ///Login olduktan sonra log out butonuyla cikis yapilabilecegi icin back butonunu bu ekranda islevsiz kalir ve bu kod ile back butonu devre disi birakilir
        title = Constants.appName
        
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        loadMessages()
        
        
    }
    
    func loadMessages() {

///        dataBase.collection(Constants.FStore.collectionName).getDocuments { (querySnapshot, error) in
        ///.getDocuments: For get data once
        dataBase.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
        ///.order(by: String) ise yuklenecek olan mesaji neye gore ui'da siralamak istiyorsan ona gore duzenlersin, bizim kodumuzda mesajlar tarihe gore siralanmistir. Boylelikle son gonderilen mesaj ui table view'de en altta gorunecektir.
            .addSnapshotListener { (querySnapshot, error) in
                ///.addSnapshotListener: For realtime getting data
               
            self.messages = []
            ///41. satirdaki Collection'a yeni bir item eklendiginde bu bos olan messages array'imize 57.satirdaki yeni mesajimiz eklenmis olur.
            
                if let e = error {
                print("Some problem has getting data from Firestore \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for document in snapshotDocuments {
                        let data = document.data()
                        if let messageSender = data[Constants.FStore.senderField] as? String,
                           let messageBody = data[Constants.FStore.bodyField] as? String {
                            
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            /// RETRIVING DATA FROM FIRESTORE
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                            //UI'in kullanimini engellemeden, queue'yi etkilemeden asyncron sekilde main'de data guncellemesi yapariz.
                            
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        
        do {
          try Auth.auth().signOut()
            
            navigationController?.popToRootViewController(animated: true)
            ///Sign out basarili oldugunda giris olan kok root ekrana doner, ki bu da bizim karsilama ekranimizdir.
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
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


