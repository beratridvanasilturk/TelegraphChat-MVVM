//
//  ChatViewController.swift
//  TelegraphChat
//
//  Created by Berat Ridvan Asilturk 23/05/2023.
//
// [EN]: English comments have been added for foreign companies.

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    // [EN] Create an object for chatviewmodel
    // [TR] chatviewmodel icin obje olusturulur
    private let viewModel = ChatViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // [EN] Since you can exit with the logout button after logging in, the back button is disabled on this screen and this code disables the back button.
        // [TR] Login olduktan sonra log out butonuyla cikis yapilabilecegi icin back butonunu bu ekranda islevsiz kalir ve bu kod ile back butonu devre disi birakilir
        navigationItem.hidesBackButton = true
        
        title = Constants.appName
        
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        viewModel.loadMessageModel( completion: { succees in
            if succees {
                print("Load Messages Succeed")
                // [EN] We update the data in main asyncronously without affecting the queue and without blocking the UI.
                // [TR] UI'in kullanimini engellemeden, queue'yi etkilemeden asyncron sekilde main'de data guncellemesi yapariz.
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                    let indexPath = IndexPath(row: self.viewModel.messages.count - 1, section: 0)
                    self.tableView?.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            }
        })
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        viewModel.logOut {
            print("succeed")
            // [EN] When sign out is successful, the login coke returns to the root screen.
            // [TR] Sign out basarili oldugunda giris olan kok root ekrana doner, ki bu da bizim karsilama ekranimizdir.
            self.navigationController?.popToRootViewController(animated: true)
        } completionFail: {
            print("failed")
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text {
            // [EN] Resets the textfield after the message has been sent.
            // [TR] Mesaj gonderildikten sonra textfield'i sifirlar
            viewModel.sendMessage(messageBody) { success in
                if success {
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    // [EN] This scope created row until messaging
    // [TR] Mesajlasma kadar table view row'u olusturur
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = viewModel.messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        // [EN] In sequence, assigns the messages to the label tag in the text.
        // [TR] Sirasiyla mesajlari text'teki label etiketine atar
        cell.label.text = message.body
        // [EN] This if line of code is the message of the current user
        // [TR] Bu if kod satiri o anki kullanicinin mesajidir
        if message.sender == viewModel.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            
            cell.messageBuble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: Constants.BrandColors.purple)
            // [EN] This else code line is the other user's message.
            // [TR] Bu else kod satiri diger kullanicinin mesajidir
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            
            cell.messageBuble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: Constants.BrandColors.purple)
               
        }
        return cell
    }
}

extension ChatViewController: UITableViewDelegate {
    // [EN] This method is triggered when the user clicks on the cell.
    // [TR] Bu method kullanici cell'e tiklandiginda tetiklenir.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // [EN] Allows us to deSelect from the selected cell
        // [TR] Secilen cell'den deSelect etmemizi saglar
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


