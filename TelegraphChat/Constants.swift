//
//  File.swift
//  TelegraphChat
//
//  Created by Berat Rıdvan Asiltürk on 26.05.2023.
//

///Herhangi bir yazim hatasi ile crashi engellemek adina tum var olan stringleri kodlarimizda kullanmak adina constant sinifina cevirdik.
struct Constants {
    
    static let appName = "✉️ TelegraphChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    

    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lightBlue = "BrandLightBlue"
    }

    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
