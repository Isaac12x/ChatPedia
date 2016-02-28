//
//  ExploreTableViewCell.swift
//  ChatPedia
//
//  Created by Nick on 2016-02-27.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryBackgroundPic: UIImageView!
    @IBOutlet weak var categorylabel: UILabel!
    @IBOutlet weak var categoryImageIcon: UIImageView!

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    
//        categoryBackgroundPic.layer.cornerRadius = 10.0
//        categoryBackgroundPic.clipsToBounds = true

//        layer.cornerRadius = 10.0
//        layer.masksToBounds = true
        
    }
    
    func configureCell(labelString: String, imageIcon: String, imageBackground: String) {
        
        categoryBackgroundPic.layer.cornerRadius = 5.0
        categoryBackgroundPic.clipsToBounds = true
        
        self.categorylabel.text = labelString
        self.categoryImageIcon.image = UIImage(named: imageIcon)
        self.categoryBackgroundPic.image = UIImage(named: imageBackground)
        
    }

}
