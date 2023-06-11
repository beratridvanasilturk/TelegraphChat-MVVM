//
//  ChatViewModel.swift
//  TelegraphChat
//
//  Created by Berat Rıdvan Asiltürk on 5.06.2023.
//
// [EN]: English comments have been added for foreign companies.

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

final class ChatViewModel {
    
    let dataBase = Firestore.firestore()
    var messages: [Message] = []
    let email = Auth.auth().currentUser?.email
    
    typealias BooleanHandler = (Bool) -> Void
    typealias VoidHandler = () -> Void
    
    func logOut(completionSuccess: @escaping VoidHandler, completionFail: @escaping VoidHandler) {
        
        do {
            
            try Auth.auth().signOut()
            
            completionSuccess()
            
        } catch let signOutError as NSError {
            
            completionFail()
            
            print("Error signing out: %@", signOutError)
        }
    }
    
    func sendMessage(_ messageBody: String, completion: @escaping BooleanHandler) {
        
        if let messageSender = Auth.auth().currentUser?.email {
            
            dataBase.collection(Constants.FStore.collectionName).addDocument(data: [ Constants.FStore.senderField: messageSender,
                                                                                     
                Constants.FStore.bodyField: messageBody,
                                                                                     
                Constants.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                
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
    
    func loadMessageModel(completion: @escaping  BooleanHandler) {
        
            dataBase.collection(Constants.FStore.collectionName)
        
            .order(by: Constants.FStore.dateField)
        // [EN] ".order" is used to organize the message to be uploaded according to what you want to order in the ui, in our code the messages are ordered by date. So the last message sent will appear at the bottom of the ui table view.
        // [TR] .order ise yuklenecek olan mesaji neye gore ui'da siralamak istiyorsan ona gore duzenlersin, bizim kodumuzda mesajlar tarihe gore siralanmistir. Boylelikle son gonderilen mesaj ui table view'de en altta gorunecektir.
        
            .addSnapshotListener { (querySnapshot, error) in
                //.addSnapshotListener: For realtime getting data
                
                // [EN] When a new item is added to the "Collection", our new message is added to this empty messages array.
                // [TR] Collection'a yeni bir item eklendiginde bu bos olan messages array'imize, yeni mesajimizi eklenmis olur.
                self.messages = []
                
                if let e = error {
                    
                    print("Some problem has getting data from Firestore \(e)")
                    
                    completion(false)
                    
                } else {
                    
                    // RETRIVING DATA FROM FIRESTORE
                    if let snapshotDocuments = querySnapshot?.documents {
                        
                        for document in snapshotDocuments {
                            
                            let data = document.data()
                            
                            if let messageSender = data[Constants.FStore.senderField] as? String,
                               
                               let messageBody = data[Constants.FStore.bodyField] as? String {
                                
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                
                                self.messages.append(newMessage)
                            }
                            completion(true)    
                        }
                    }
                  
                }
            }
    }
    
}
