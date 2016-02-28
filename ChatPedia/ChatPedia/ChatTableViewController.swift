//
//  ChatTableViewController.swift
//  ChatPedia
//
//  Created by Douglas Hewitt on 2/26/16.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit
import FirebaseUI
import Firebase

class ChatTableViewController: UITableViewController, HandleAuthProtocol {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if CurrentUser.sharedInstance.authData == nil {
            
            presentLoginController()
        }
    }
    

    
    func presentLoginController() {
        let loginVC = UIStoryboard(name: StoryboardID.Utilities.rawValue, bundle: nil).instantiateViewControllerWithIdentifier(StoryboardID.Login.rawValue)
        self.presentViewController(loginVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ChatTableViewCell.identifier, forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let chatVC = ChatViewController()
        chatVC.hidesBottomBarWhenPushed = true
        self.showViewController(chatVC, sender: nil)
    }



}
