//
//  ChatViewController.swift
//  TelegraphChat
//
//  Created by Berat Ridvan Asilturk 23/05/2023.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    //chatviewmodel icin obje olusturulur
    private let viewModel = ChatViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //Login olduktan sonra log out butonuyla cikis yapilabilecegi icin back butonunu bu ekranda islevsiz kalir ve bu kod ile back butonu devre disi birakilir
        navigationItem.hidesBackButton = true
        
        title = Constants.appName
        
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        viewModel.loadMessageModel( completion: { succees in
            if succees {
                print("Load Messages Succeed")
                
                //UI'in kullanimini engellemeden, queue'yi etkilemeden asyncron sekilde main'de data guncellemesi yapariz.
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
            //Sign out basarili oldugunda giris olan kok root ekrana doner, ki bu da bizim karsilama ekranimizdir.
            self.navigationController?.popToRootViewController(animated: true)
        } completionFail: {
            print("failed")
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text {
            
            //Mesaj gonderildikten sonra textfield'i sifirlar
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
    
    //Mesajlasma kadar table view row'u olusturur
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = viewModel.messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        //Sirasiyla mesajlari text'teki label etiketine atar
        cell.label.text = message.body
    
        // Bu if kod satiri o anki kullanicinin mesajidir
        if message.sender == viewModel.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            
            cell.messageBuble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: Constants.BrandColors.purple)
            
            // Bu else kod satiri diger kullanicinin mesajidir
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
    
    //Bu method kullanici cell'e tiklandiginda tetiklenir.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //secilen cell'den deSelect etmemizi saglar
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


