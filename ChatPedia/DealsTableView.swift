//
//  DealsTableView.swift
//  ChatPedia
//
//  Created by Isaac Albets Ramonet on 27/02/16.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit
import MapKit


class DealsTableView: UITableViewController {
    
    let kCloseCellHeight: CGFloat = 488
    let kRowsCount = 1
    var cellHeights = [CGFloat]()
    var url = NSBundle.mainBundle().pathForResource("DealLocations", ofType: "json")
    var deepLink: String!
    var sharedSession: NSURLSession!
    
    typealias CompletionHandler = (result: AnyObject!, error: ErrorType?) -> Void
    
    var newYorkQuery = NSURL(string: "http://terminal2.expedia.com:80/x/deals/packages?originTLA=SFO&destinationTLA=JFK&startDate=2016-02-28&endDate=2016-03-06&lengthOfStay=5&roomCount=1&adultCount=1&childCount=0&infantCount=0&limit=50&sortOrder=Desc&sortStrategy=SavingsPercentage&allowDuplicates=false")
    
    var lasVegasQuery = NSURL(string: "http://terminal2.expedia.com:80/x/deals/packages?originTLA=SFO&destinationTLA=LAS&startDate=2016-02-28&endDate=2016-03-06&lengthOfStay=5&roomCount=1&adultCount=1&childCount=0&infantCount=0&limit=50&sortOrder=Desc&sortStrategy=SavingsPercentage&allowDuplicates=false")
    
    let losAngelesQuery = NSURL(string: "http://terminal2.expedia.com:80/x/deals/packages?originTLA=SFO&destinationTLA=LAX&startDate=2016-02-28&endDate=2016-03-06&lengthOfStay=5&roomCount=1&adultCount=1&childCount=0&infantCount=0&limit=50&sortOrder=Desc&sortStrategy=SavingsPercentage&allowDuplicates=false")
    

    override func viewDidLoad() {
        super.viewDidLoad()

        createCellHeightsArray()
        
          self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        self.tabBarController!.tabBar.barTintColor = UIColor.blueColor()
        self.tabBarController!.tabBar.tintColor = UIColor.whiteColor()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Not in SF?", style: .Plain, target: "AddDatePicker", action: "performSegue:")
    
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = "Deals"

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
        let request = sharedSession.dataTaskWithRequest(toReq) { (data, response, error) in
            
            guard (error == nil) else {
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                if let _ = response as? NSHTTPURLResponse {
                    completionHandler(result: false, error: error)
                } else if let _ = response {
                    completionHandler(result: false, error: error)
                } else {
                    completionHandler(result: false, error: error)
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
                completionHandler(result: false, error: error)
            }
            
            
            if let results = parsedResult["deals"] as? [[String: AnyObject]]{
                for result in results{
                    for x in results{
                     //   if x == "totalPackagePrice"{
                     return
                    
                    }
                }
            } else {
                completionHandler(result: false, error: error)
            }
    
        }
        request.resume()
    }
    

    
    
}