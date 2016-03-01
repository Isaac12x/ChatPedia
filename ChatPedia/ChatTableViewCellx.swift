//
//  ChatTableViewCell.swift
//  ChatPedia
//
//  Created by Douglas Hewitt on 2/26/16.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit
import Firebase

class ChatTableViewCell: UITableViewCell {
    
    static let identifier = "ChatCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    var roomRef: Firebase!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
