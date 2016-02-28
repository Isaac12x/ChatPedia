//
//  ExploreController.swift
//  ChatPedia
//
//  Created by Christine Le on 2/27/16.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import Foundation
import Alamofire

class ExploreModel: NSObject {
    
    func getSearch()
    {
        Alamofire.request(.GET, "http://terminal2.expedia.com/x/activities/search?location=sanfrancisco&apikey=nTUFxddWMLArDoSLLSegm870PAG2GCID")
   
//        Alamofire.request(.GET, "http://terminal2.expedia.com/x/activities/search?location=sanfrancisco&apikey=nTUFxddWMLArDoSLLSegm870PAG2GCID")
//        .responseData { response in
//        print(response.request)
//        print(response.response)
//        print(response.result)
//        }
//        
    }
    
//    getSearch()
}
