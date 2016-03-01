//
//  ExploreDetailTableViewCell.swift
//  ChatPedia
//
//  Created by Nick on 2016-02-28.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit
import Firebase

class ExploreDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var supplierLabel: UILabel!
    @IBOutlet weak var recommendationLabel: UILabel!
    
    var roomRef: Firebase!
    

    func configureCell(picBackground: String, thumbnailBackground: String, title: String, currentPrice: String, favoriteButt: String, duration: String, supplier: String, recommend: String) {
        
        backgroundImage.layer.cornerRadius = 7.0
        backgroundImage.clipsToBounds = true
        
        thumbnailImage.layer.cornerRadius = 5.0
        thumbnailImage.clipsToBounds = true
        
        self.backgroundImage.image = UIImage(named: picBackground)
        self.thumbnailImage.image = UIImage(named: thumbnailBackground)
        self.titleLabel.text = title
        self.currentPriceLabel.text = currentPrice
        self.favoriteButton.image = UIImage(named: favoriteButt)
        self.durationLabel.text = duration
        self.supplierLabel.text = supplier
        self.recommendationLabel.text = recommend
    }

}
