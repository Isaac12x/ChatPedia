//
//  ExploreTableViewController.swift
//  ChatPedia
//
//  Created by Nick on 2016-02-27.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit


import MapKit
import EZSwiftExtensions
import LNRSimpleNotifications
import AudioToolbox


class ExploreTableViewController: UITableViewController {

    var categoryArr :[String] = ["Day Trips & Excursions", "Food & Drink", "Tours & Sightseeing", "Attractions", "Air & Helicopter Tours", "Adventures","Walking & Bike Tours", "Sightseeing Passes"]
    var categoryIconArr :[String] = ["category_icon1","category_icon2","category_icon3","category_icon4","category_icon5","category_icon6","category_icon7","category_icon8"]
    var categoryPicBackArr :[String] = ["category1","category2","category3","category4","category5","category6","category7","category8"]

    
    var manager: OneShotLocationManager?
    
    var realLocation: CLLocation!
    var expectedCoordinates: CLLocation!
    let notificationManager = LNRNotificationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //firebase login
        if CurrentUser.sharedInstance.authData == nil {
            CoreFirebaseData.sharedInstance.ref.authAnonymouslyWithCompletionBlock { (error, authData) -> Void in
                if let error = error {
                    print("in \(self.classForCoder) error: \(error.description)")
                } else if let auth = authData {
                    CurrentUser.sharedInstance.authData = auth
                    CurrentUser.sharedInstance.dummyProfileInfo()
                    
                }
            }
            
        }
        
             self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
                
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "")
        
        // Get location
        manager = OneShotLocationManager()
        manager!.fetchWithCompletion { location, error in
            
            // fetch location or an error
            if let loc = location {
                self.realLocation = loc
                print(loc)
            }
            
            self.manager = nil
        }
        self.notificationOnDeal()
        
        tableView.reloadData()

    }
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = "Explore"
    }
    
    func notificationOnDeal() {
        notificationManager.notificationsPosition = LNRNotificationPosition.Top
        notificationManager.notificationsBodyTextColor = UIColor.darkGrayColor()
        
        let alertSoundURL: NSURL? = NSBundle.mainBundle().URLForResource("click", withExtension: "wav")
        if let _ = alertSoundURL {
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(alertSoundURL!, &mySound)
            notificationManager.notificationSound = mySound
        }
        
    }
    
    
    func methodThatTriggersNotification(title: String, body: String) {
        notificationManager.showNotification("Save up to 25 %", body: "Are you going to miss the \(realLocation) deal?", callback: { () -> Void in
            self.notificationManager.dismissActiveNotification({ () -> Void in
                print("Notification dismissed")
            })
        })
    }
    



    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("ExploreTableViewCell", forIndexPath: indexPath) as? ExploreTableViewCell {
            
            cell.configureCell(categoryArr[indexPath.row], imageIcon: categoryIconArr[indexPath.row], imageBackground: categoryPicBackArr[indexPath.row])
            
            return cell
        } else {
            return UITableViewCell()
        }
    }

   
}
