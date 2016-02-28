//
//  FirstViewController.swift
//  ChatPedia
//
//  Created by Isaac Albets Ramonet on 26/02/16.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func didTapLogin(sender: UIButton) {
        CoreFirebaseData.sharedInstance.ref.authAnonymouslyWithCompletionBlock { (error, authData) -> Void in
            if let error = error {
                print("in \(self.classForCoder) error: \(error.description)")
            } else if let auth = authData {
                CurrentUser.sharedInstance.authData = auth
                CurrentUser.sharedInstance.dummyProfileInfo()
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }
        }
        
    }
    
    // MARK: - Load
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

