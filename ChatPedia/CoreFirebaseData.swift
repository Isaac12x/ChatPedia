//
//  CoreFirebaseData.swift
//  ChatPedia
//
//  Created by Douglas Hewitt on 2/26/16.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit
import Firebase

class CoreFirebaseData: NSObject {
    static let sharedInstance = CoreFirebaseData()
    
    var ref: Firebase!

    func connect() {
        ref = Firebase(url: "https://incandescent-heat-9398.firebaseio.com")
    }

}
