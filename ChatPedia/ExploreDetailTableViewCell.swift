//
//  ExploreDetailTableViewCell.swift
//  ChatPedia
//
//  Created by Nick on 2016-02-28.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit

class ExploreDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previousPrice: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var supplierLabel: UILabel!
    
    

    func configureCell() {
        
        backgroundImage.layer.cornerRadius = 7.0
        backgroundImage.clipsToBounds = true
        
        thumbnailImage.layer.cornerRadius = 5.0
        thumbnailImage.clipsToBounds = true
        
        self.backgroundImage.image = UIImage(named: "")
        self.thumbnailImage.image = UIImage(named: "")
        self.titleLabel.text = ""
        self.previousPrice.text = ""
        self.currentPriceLabel.text = ""
        self.favoriteButton.image = UIImage(named: "")
        self.durationLabel.text = ""
        self.supplierLabel.text = ""
    }

}
