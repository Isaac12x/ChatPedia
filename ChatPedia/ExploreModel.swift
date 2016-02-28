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
    
    var chatTitle : String!
    var backgroundImage : String!
    var thumbnailImage : String!
    var previousPrice : String!
    var currentPrice : String!
    var favorite : String!
    var duration : String!
    var supplierName : String!
    
    func getSearch()
    {
        let url = NSURL(string: "http://terminal2.expedia.com/x/activities/search?location=sanfrancisco&apikey=nTUFxddWMLArDoSLLSegm870PAG2GCID")!
   
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let activity = dict["activities"] as? [Dictionary<String, AnyObject>] where activity.count > 0 {
                    
                    for var x = 0; x < 5 || x < activity.count; x++ {
                        if let title = activity[0]["title"] as? String{
                            self.chatTitle = title
                        }
                        
                        if let largeImageURL = activity[0]["largeImageURL"] as? String{
                            self.backgroundImage = largeImageURL
                        }
                        
                        if let imageUrl = activity[0]["imageUrl"] as? String{
                            self.thumbnailImage = imageUrl
                        }
                        
                        if let fromOriginalPrice = activity[0]["fromOriginalPrice"] as? String{
                            self.previousPrice = fromOriginalPrice
                        }
                        
                        if let fromPrice = activity[0]["fromPrice"] as? String{
                            self.currentPrice = fromPrice
                        }
                        
                        if let recommendationScore = activity[0]["recommendationScore"] as? String{
                            self.favorite = recommendationScore
                        }
                        
                        if let duration = activity[0]["duration"] as? String{
                            self.duration = duration
                        }
                        
                        if let supplierName = activity[0]["supplierName"] as? String{
                            self.supplierName = supplierName
                        }
                        
                        // Testing:  confirm values here
                        print(self.chatTitle)
                        print(self.backgroundImage)
                        print(self.thumbnailImage)
                        print(self.previousPrice)
                        print(self.currentPrice)
                        print(self.favorite)
                        print(self.duration)
                        print(self.supplierName)
                    }
                    
                }
            }
        }
    }
}
