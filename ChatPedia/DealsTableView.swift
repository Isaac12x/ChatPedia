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

class DealsTableView: UITableViewController {
    
    let kCloseCellHeight: CGFloat = 1200
    let kRowsCount = 1
    var cellHeights = [CGFloat]()
    var url = NSBundle.mainBundle().pathForResource("DealLocations", ofType: "json")
    var deepLink: String!
    var session: NSURLSession!
    
    var priceFromApi: [AnyObject]!
    var goToLink: [AnyObject]!
    
    var tasksDidEnd = 3
    
    let linearBar: LinearProgressBar = LinearProgressBar()
    
    typealias CompletionHandler = (success: Bool, error: ErrorType?) -> Void
    
    var newYorkQuery = NSURL(string: "http://terminal2.expedia.com:80/x/deals/packages?originTLA=SFO&destinationTLA=JFK&startDate=2016-02-28&endDate=2016-03-06&lengthOfStay=5&roomCount=1&adultCount=1&childCount=0&infantCount=0&limit=50&sortOrder=Desc&sortStrategy=SavingsPercentage&allowDuplicates=false")
    
    var lasVegasQuery = NSURL(string: "http://terminal2.expedia.com:80/x/deals/packages?originTLA=SFO&destinationTLA=LAS&startDate=2016-02-28&endDate=2016-03-06&lengthOfStay=5&roomCount=1&adultCount=1&childCount=0&infantCount=0&limit=50&sortOrder=Desc&sortStrategy=SavingsPercentage&allowDuplicates=false")
    
    let losAngelesQuery = NSURL(string: "http://terminal2.expedia.com:80/x/deals/packages?originTLA=SFO&destinationTLA=LAX&startDate=2016-02-28&endDate=2016-03-06&lengthOfStay=5&roomCount=1&adultCount=1&childCount=0&infantCount=0&limit=50&sortOrder=Desc&sortStrategy=SavingsPercentage&allowDuplicates=false")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        session = NSURLSession.sharedSession()
        createCellHeightsArray()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)   
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Not in SF?", style: .Plain, target: self, action: "buttonPressed")
        

        self.view.addSubview(linearBar)
        self.linearBar.startAnimation()
        
        self.taskForGet(newYorkQuery!) { (success, error) in
            
            if success{
                print(self.priceFromApi)
                
                // Do some configuration with the data
                
                
                // Grab best price + deep link
            } else{
                SweetAlert().showAlert("Ouch!", subTitle: "Something went wrong, please forgive us!", style: AlertStyle.Success)

            }
            
        }
//        self.taskForGet(lasVegasQuery)
//        self.taskForGet(losAngelesQuery)
        
        
        
    }
    
    func buttonPressed(){
        navigationController?.presentVC(AddDataPicker())
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if tasksDidEnd == 0{
            self.linearBar.alpha = 0.0
            self.linearBar.stopAnimation()
        } else{
            self.linearBar.alpha = 0.0
            self.linearBar.startAnimation()
        }
    }
    
    
//    if realLocation == expectedCoordinates{
//        return
//    }
    
    // MARK: configure
    func createCellHeightsArray() {
        for _ in 0...kRowsCount {
            cellHeights.append(kCloseCellHeight)
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell is FoldingCell {
            let foldingCell = cell as! FoldingCell
            foldingCell.backgroundColor = UIColor.clearColor()
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
        
        _ = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
        
        UIApplication.sharedApplication().openURL(NSURL(string: "deepLink")!)
        
    }
    
    func taskForGet(query: NSURL, completionHandler: CompletionHandler){
        
        let toReq = NSURLRequest(URL: query)
        let request = session.dataTaskWithRequest(toReq) { (data, response, error) in
            
            guard (error == nil) else {
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                if let _ = response as? NSHTTPURLResponse {
                    completionHandler(success: false, error: error)
                } else if let _ = response {
                    completionHandler(success: false, error: error)
                } else {
                    completionHandler(success: false, error: error)
                }
                return
            }
            
            guard let data = data else {
                print("The request returned no data")
                return
            }
            
            var parsedResult: AnyObject!
            do{
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            } catch{
                _ = [NSLocalizedDescriptionKey : "Could not parse the JSON: '\(data)'"]
                completionHandler(success: false, error: error)
            }
            
            
            if let results = parsedResult["deals"] as? [[String: AnyObject]]{
                for result in results{
                    for (key, value) in result{
                      if key == "totalPackagePrice"{
                            self.priceFromApi.append(value)
                        }
                        
                        if key == "deeplink"{
                            self.goToLink.append(value)
                        }
                    }
                }
            } else {
                completionHandler(success: false, error: error)
            }
    
        }
        request.resume()
        self.tasksDidEnd--
    }
    

    
    
}