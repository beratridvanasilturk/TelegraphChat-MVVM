//
//  AppDelegate.swift
//  TelegraphChat
//
//  Created by Berat Ridvan Asilturk 23/05/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
//Firebaseleri ice aktarilir
import IQKeyboardManagerSwift
//

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        //Firebase baglamasi gerceklesmis olur.
        IQKeyboardManager.shared.enable = true
        //IqKeyboardManager third party ile gelen bir kod satiridir, kisaca IKM; keyboard'in ui'da daha iyi bir kullanici deneyimi sunar
        IQKeyboardManager.shared.enableAutoToolbar = false
        ///Toolbar'i kapatarak ui'da alan kazanmamizi saglar
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        /// UI'da keyboard disinda bir yere tiklandiginda keyboard'i gizlemeye yarar
    
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

