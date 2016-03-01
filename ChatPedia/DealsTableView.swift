//
//  DealsTableView.swift
//  ChatPedia
//
//  Created by Isaac Albets Ramonet on 27/02/16.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit
import MapKit
import LNRSimpleNotifications
import AudioToolbox

class DealsTableView: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toURL: UIView!
    @IBOutlet weak var updateView: UIView!
    @IBOutlet weak var tpView: UIView!
    @IBOutlet weak var noView: UILabel!
    
    var newYorkQuery = NSURL(string: "http://expedia.com/go/package/search/FlightHotel/2016-03-25/2016-03-30?FromAirport=SFO&Destination=JFK&NumRoom=1&NumAdult=1&NumChild=0&hotelId=789469")
    
    var lasVegasQuery = NSURL(string: "http://expedia.com/go/package/search/FlightHotel/2016-03-25/2016-03-30?FromAirport=SFO&Destination=LAS&NumRoom=1&NumAdult=1&NumChild=0&hotelId=19558")
    
    let losAngelesQuery = NSURL(string: "http://expedia.com/go/package/search/FlightHotel/2016-03-24/2016-03-29?FromAirport=SFO&Destination=LAX&NumRoom=1&NumAdult=1&NumChild=0&hotelId=2104424")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "LemonMilk", size: 20)!,
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        
        self.navigationItem.title = "UNREAL DEALS"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Not in SF?", style: .Plain, target: self, action: "buttonPressed")
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
    
        self.imageView.image = UIImage(named: "NewYorkArtboard")
        
        toURL.addTapGesture { (gesture) -> () in
        UIApplication.sharedApplication().openURL(self.newYorkQuery!)
        }
        
        if imageView.image == UIImage(named: "NewYorkArtboard"){
            updateView.addTapGesture(action: { (gesture) -> () in
                self.imageView.image = UIImage(named: "LasVegasArtboard")
            })
            toURL.addTapGesture(action: { (gesture) -> () in
                UIApplication.sharedApplication().openURL(self.lasVegasQuery!)
            })
        } else if imageView.image == UIImage(named: "LasVegasArtboard"){
            updateView.addTapGesture(action: { (gesture) -> () in
                self.imageView.image = UIImage(named: "LosAngelesArtboard")
            })
            toURL.addTapGesture(action: { (gesture) -> () in
                UIApplication.sharedApplication().openURL(self.losAngelesQuery!)
            })
        } else {
            SweetAlert().showAlert("Almost there!", subTitle: "There are even more trends and cool travels around the corner", style: AlertStyle.Warning, buttonTitle:"Stay", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "Go", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
                if isOtherButton == true {
                    
                    SweetAlert().showAlert("Great!", subTitle: "You are staying with us!", style: AlertStyle.Success)
                }
                else {
                    SweetAlert().showAlert("Warning", subTitle: "Your are leaving the app", style: AlertStyle.Warning)
                    UIApplication.sharedApplication().openURL(NSURL(string: "https://www.expedia.com/Vacation-Packages")!)
                }
            }
        }

        
        toURL.alpha = 0.1
        updateView.alpha = 0.1
        
    }
    
    func buttonPressed(){
        navigationController?.pushVC(AddDataPicker())
    }

}