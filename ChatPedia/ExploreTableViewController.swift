//
//  DealsTableView.swift
//  ChatPedia
//
//  Created by Isaac Albets Ramonet on 27/02/16.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit
import MapKit
import EZSwiftExtensions
import LNRSimpleNotifications
import AudioToolbox

class ExploreTableView : UITableViewController{
    
    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
    let kRowsCount = 10
    var cellHeights = [CGFloat]()
    
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
                
        createCellHeightsArray()

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
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = "Explore"
        
//        let appearance = UITabBarItem.appearance()
//        let attributes = [NSFontAttributeName:UIFont(name: "LemonMilk", size: 20)]
//        appearance.setTitleTextAttributes(attributes, forState: .Normal)
        

       
    }

    func notificationOnDeal() {
        notificationManager.notificationsPosition = LNRNotificationPosition.Top
        notificationManager.notificationsBodyTextColor = UIColor.darkGrayColor()
        
        var alertSoundURL: NSURL? = NSBundle.mainBundle().URLForResource("click", withExtension: "wav")
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

    
    // MARK: configure
    func createCellHeightsArray() {
        for _ in 0...kRowsCount {
            cellHeights.append(kCloseCellHeight)
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell is FoldingCell {
            let exploreCell = cell as! FoldingCell
            exploreCell.backgroundColor = UIColor.clearColor()
            
            if cellHeights[indexPath.row] == kCloseCellHeight {
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoldingCell", forIndexPath: indexPath)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    // MARK: Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
    }

}