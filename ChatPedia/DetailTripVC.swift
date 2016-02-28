//
//  DetailTripVC.swift
//  ChatPedia
//
//  Created by Nick on 2016-02-28.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit
import Firebase

class DetailTripVC: UIViewController {
    
    @IBOutlet weak var currentPrice: UILabel!
    @IBOutlet weak var tripTopImage: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    @IBOutlet weak var tripBottomImage: UIImageView!
    @IBOutlet weak var adultCostLabel: UILabel!
    @IBOutlet weak var childCostLabel: UILabel!
    @IBOutlet weak var tripDateLabel: UILabel!
    @IBOutlet weak var buttonChat: UIButton!
    
    var stuff: DetailData!
    var roomRef: Firebase?

    
    //note tripTop Image will be a blur image of the attraction
    //tripBottom Image will be a blur image as well.

    //need a data variable from the model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateUI()
        
        buttonChat.layer.cornerRadius = 5.0
        buttonChat.clipsToBounds = true
        


    }
    
    func updateUI() {
        
//        self.currentPrice.text = stuff.priceToPass
//        self.tripTopImage.image = UIImage(named: "\(stuff.thumbnail)")
//        self.tripBottomImage.image = UIImage(named: "\(stuff.thumbnail)")
//        self.durationLabel.text = stuff.durationToPass
//        self.descriptionLabel.text = ""
//        self.adultCostLabel.text = stuff.adultCostToPass
//        self.childCostLabel.text = stuff.childCostToPass
//        self.tripDateLabel.text = stuff.tripDateToPass
        
    }

        // MARK: - Navigation

    @IBAction func jumpToChatGroupButton(sender: AnyObject) {
        
        let chatVC  = ChatViewController()
        if let ref = self.roomRef {
            chatVC.roomRef = ref
            chatVC.hidesBottomBarWhenPushed = true
            self.showViewController(chatVC, sender: nil)
        } else {
            
        }

        
    }
}
