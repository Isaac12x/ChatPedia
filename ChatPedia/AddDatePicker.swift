//
//  File.swift
//  ChatPedia
//
//  Created by Isaac Albets Ramonet on 27/02/16.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit
import Eureka

class AddDataPicker : FormViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.pushVC(AddDataPicker())
        
        form.inlineRowHideOptions = InlineRowHideOptions.AnotherInlineRowIsShown.union(.FirstResponderChanges)
        
        
        form
            +++ Section("Are you staying more days?")
            
            <<< DateInlineRow() {
                $0.title = "Pick last day in town"
                $0.value = NSDate()
                
                
                self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
                
                
        }
        
        
        let aaa = UIView(x: 0, y: 0, w: 100, h: 500)
        aaa.addSubview(self.view)
        view.addSubview(aaa)
    }
    
    //func values(includeHidden includeHidden: Bool = false) -> [String: Any?]
    
}
