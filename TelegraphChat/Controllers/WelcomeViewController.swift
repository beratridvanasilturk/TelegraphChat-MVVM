//
//  WelcomeViewController.swift
//  TelegraphChat
//
//  Created by Berat Ridvan Asilturk 23/05/2023.
//
import UIKit
import CLTypingLabel


class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    ///Pod icin label'i ClTypingLabel olarak ayarladik
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = Constants.appName
//        
//        titleLabel.text = ""
//        var chracterIndex = 0.0
//        let titleText = "⚡️TelegraphChat"
//        for letter in titleText {
//            Timer.scheduledTimer(withTimeInterval: 0.5 * chracterIndex, repeats: false) { (timer) in
//                self.titleLabel.text?.append(letter)
//            }
//            chracterIndex += 1
//        }
        ///Text'i normal bicimde herhangi bir pod kullanmadan animasyon haline getirir, ve bunu her bir harf icin ayni anda yapmasini engellemek adina da chracterIndex tanimladik .
       
    }
}
        
