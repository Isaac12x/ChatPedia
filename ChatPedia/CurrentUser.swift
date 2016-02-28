//
//  CurrentUser.swift
//  ChatPedia
//
//  Created by Douglas Hewitt on 2/26/16.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit
import Firebase

class CurrentUser: NSObject {
    static let sharedInstance = CurrentUser()
    
    var authData: FAuthData!
    var displayName: String?
    var profileImageRef: NSURL?
    var profileImage: UIImage?
    
    func dummyProfileInfo() {
        displayName = "Jonny"
    }
}
