//
//  File.swift
//  ChatPedia
//
//  Created by Isaac Albets Ramonet on 27/02/16.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit
import Eureka
import EZSwiftExtensions

class AddDataPicker : FormViewController{
    
    var data : [String: Any?]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "LemonMilk", size: 20)!,
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        
        navigationController?.navigationItem.title = "ChatPedia"
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelViewController:")
        
        form.inlineRowHideOptions = InlineRowHideOptions.AnotherInlineRowIsShown.union(.FirstResponderChanges)
        
        
        form
            +++ Section("What's your last traveling day?")
            
            <<< DateInlineRow() {
                $0.title = "Pick last day in town"
                $0.value = NSDate()
                
                
                self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
                
        form
            +++ Section("How many adults are you traveling with?")
            <<< SegmentedRow<String>(){
                $0.options = ["1", "2", "3", "4", "+5"]
                $0.value = "3"
                }.cellSetup { cell, row in
                    cell.titleLabel?.text = "Adults: "
                }
        form
            +++ Section("How many kids are you traveling with?")
            <<< SegmentedRow<String>(){
                $0.options = ["1", "2", "3", "4", "+5"]
                $0.value = "3"
                }.cellSetup { cell, row in
                    cell.titleLabel?.text = "Kids: "
                }

        }
      
        func cancelViewController(){
            navigationController!.popViewControllerAnimated(true)
        }
    
    
    //func values(includeHidden includeHidden: Bool = false) -> [String: Any?]
    
    }
}