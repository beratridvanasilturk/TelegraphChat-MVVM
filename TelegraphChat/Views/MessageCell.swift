//
//  MessageCell.swift
//  TelegraphChat
//
//  Created by Berat Rıdvan Asiltürk on 27.05.2023.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet var messageBuble: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var rightImageView: UIImageView!
    @IBOutlet var leftImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageBuble.layer.cornerRadius = messageBuble.frame.size.height / 10
        ///Messaj buble metnini cerceve uzunluguna gore kosesi trim edilir, radius eklenir
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
