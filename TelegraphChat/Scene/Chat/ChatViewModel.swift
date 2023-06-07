//
//  ChatViewModel.swift
//  TelegraphChat
//
//  Created by Berat Rıdvan Asiltürk on 5.06.2023.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

final class ChatViewModel {
    
    let dataBase = Firestore.firestore()
    var messages: [Message] = []
    let email = Auth.auth().currentUser?.email
    
    typealias SuccessLoadMessage = (Bool) -> Void
    typealias SuccessLogOut = (Bool) -> Void
    typealias SuccessSendMessage = (Bool) -> Void
    
    func logOut(completion: @escaping SuccessLogOut) {
        do {
            try Auth.auth().signOut()
            
            completion(true)
        } catch let signOutError as NSError {
            completion(false)
            print("Error signing out: %@", signOutError)
        }
    }
    
    
    func sendMessage(_ messageBody: String, completion: @escaping SuccessSendMessage) {
        
        if let messageSender = Auth.auth().currentUser?.email {
            dataBase.collection(Constants.FStore.collectionName).addDocument(data: [ Constants.FStore.senderField: messageSender,
                                                                                     Constants.FStore.bodyField: messageBody,
                                                                                     Constants.FStore.dateField: Date().timeIntervalSince1970    ]) { (error) in
                
                if let e = error {
                    print("Some issues with about saving data to firestore. \(e)")
                    completion(false)
                } else {
                    print("Succesfully data saved.")
                    completion(true)
                    
                }
            }
        }
    }
    
    
    func loadMessageModel(completion: @escaping  SuccessLoadMessage) {
        
        
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
                    completion(false)
                } else {
        
                    if let snapshotDocuments = querySnapshot?.documents {
                        for document in snapshotDocuments {
                            let data = document.data()
                            if let messageSender = data[Constants.FStore.senderField] as? String,
                               let messageBody = data[Constants.FStore.bodyField] as? String {
                                
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                /// RETRIVING DATA FROM FIRESTORE
                                
                                
                             
                            }
                            completion(true)    
                        }
                    }
                  
                }
            }
    }
    
    
}
