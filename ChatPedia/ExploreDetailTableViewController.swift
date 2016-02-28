//
//  ExploreDetailTableViewController.swift
//  ChatPedia
//
//  Created by Nick on 2016-02-28.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit

class ExploreDetailTableViewController: UITableViewController {

    var picBackground : [String] = ["detail_activity_san_fran_big2","detail_activity_boat_big2","detail_activity_yosemite_big2"]
    var thumbnailBackground : [String] = ["detail_activity_san_fran_small","detail_activity_boat_small","detail_activity_yosemite_small"]
    var titleName : [String] = ["Alcatraz Package: Hop-On Hop-Off Cruise", "Golden Gate Bay Cruise", "Yosemite National Park Day Tour"]
    var currentPrice : [String] = ["135", "30", "149"]
    var favoriteButton : [String] = ["favorite_icon","favorite_icon","favorite_icon"]
    var duration : [String] = ["2 Days +", "1h", "13h 30m"]
    var supplier : [String] = ["Big Bus Tours", "Red & White Fleet", "Gray Line San Francisco"]
    var recommendation :[String] = ["77","73","55"]
    
    //var valueToPass:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return picBackground.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("ExploreDetailTableViewCell", forIndexPath: indexPath) as? ExploreDetailTableViewCell {
            
            let roomsQuery = CoreFirebaseData.sharedInstance.ref.childByAppendingPath("room").queryOrderedByChild("name").queryLimitedToLast(25)
            roomsQuery.observeEventType(.ChildAdded, withBlock: { (snap) -> Void in
                cell.roomRef = CoreFirebaseData.sharedInstance.ref.childByAppendingPath("room").childByAppendingPath(snap.key)
            })

        
            cell.configureCell(picBackground[indexPath.row], thumbnailBackground: thumbnailBackground[indexPath.row], title: titleName[indexPath.row], currentPrice: currentPrice[indexPath.row], favoriteButt: favoriteButton[indexPath.row], duration: duration[indexPath.row], supplier: supplier[indexPath.row], recommend: recommendation[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as? ExploreDetailTableViewCell
        
        
        let thingsToPass = DetailData()
        thingsToPass.priceToPass = currentCell!.currentPriceLabel.text
        thingsToPass.durationToPass = currentCell?.durationLabel.text
        thingsToPass.adultCostToPass = currentCell?.currentPriceLabel.text
        thingsToPass.childCostToPass = currentCell?.currentPriceLabel.text
        thingsToPass.tripDateToPass = currentCell?.durationLabel.text
        //thingsToPass.thumbnail = currentCell?.thumbnailImage.text
        //thingsToPass.topImageToPass = currentCell?.picbackground.text
        
        if let vc = UIStoryboard(name: StoryboardID.Main.rawValue, bundle: nil).instantiateViewControllerWithIdentifier("DetailTripVC") as? DetailTripVC {
            vc.stuff = thingsToPass
            vc.roomRef = currentCell?.roomRef
            self.showViewController(vc, sender: nil)
        }
        
    }
    
    
}
