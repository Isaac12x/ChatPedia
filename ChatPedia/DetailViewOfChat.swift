//
//  ViewDetail.swift
//  Pods
//
//  Created by Isaac Albets Ramonet on 28/02/16.
//
//

import UIKit

class DetailViewOfChat: UIViewController {
    
    var bckImage = UIImageView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "dismissVC")
        
        bckImage.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        bckImage.image = UIImage(named: "ChatView")
        view.addSubview(bckImage)
    }
    
    func dismissVC(){
        self.dismissVC(completion: nil)
    }
    
}
private var screenOrientation: UIInterfaceOrientation {
    return UIApplication.sharedApplication().statusBarOrientation
}

private var screenWidth: CGFloat {
    if UIInterfaceOrientationIsPortrait(screenOrientation) {
        return UIScreen.mainScreen().bounds.size.width
    } else {
        return UIScreen.mainScreen().bounds.size.height
    }
}

/// EZSwiftExtensions
private var screenHeight: CGFloat {
    if UIInterfaceOrientationIsPortrait(screenOrientation) {
        return UIScreen.mainScreen().bounds.size.height
    } else {
        return UIScreen.mainScreen().bounds.size.width
    }
}


