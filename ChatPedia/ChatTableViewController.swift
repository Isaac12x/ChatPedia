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

    var firebaseDataSource: FirebaseTableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        self.firebaseDataSource = FirebaseTableViewDataSource(ref: CoreFirebaseData.sharedInstance.ref.childByAppendingPath("room"), cellClass: ChatTableViewCell.self, cellReuseIdentifier: ChatTableViewCell.identifier, view: self.tableView)
        
        self.firebaseDataSource.populateCellWithBlock { (cell: UITableViewCell, obj: NSObject) -> Void in
            let snap = obj as! FDataSnapshot
            print(snap.description)
            let cell = cell as! ChatTableViewCell
            
            // Populate cell as you see fit, like as below
            let title = snap.value["name"] as? String
            print(title)
            cell.textLabel?.text = title
            
            cell.roomRef = CoreFirebaseData.sharedInstance.ref.childByAppendingPath("room").childByAppendingPath(snap.key)
        }
        
        self.tableView.dataSource = self.firebaseDataSource
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
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ChatTableViewCell
        let chatVC = ChatViewController()
        chatVC.roomRef = cell.roomRef
        chatVC.hidesBottomBarWhenPushed = true
        self.showViewController(chatVC, sender: nil)
    }



}
