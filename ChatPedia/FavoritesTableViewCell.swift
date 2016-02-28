//
//  FavoritesTableViewCell.swift
//  ChatPedia
//
//  Created by Nick on 2016-02-27.
//  Copyright © 2016 LaunchHackathon. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    public typealias CompletionHandler = () -> Void
    
    @IBOutlet weak public var foregroundView: FavoriteCellView!
    var animationView: UIView?
    
    
    @IBInspectable public var backViewColor: UIColor = UIColor.brownColor()
    
    
    // MARK:  life cicle
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        configureDefaultState()
        
        self.selectionStyle = .None
        
    }
    
    // MARK: configure
    
    func configureDefaultState() {
        let foregroundTopConstraint = self.contentView.constraints.filter{ $0.identifier == "ForegroundViewTop"}.first
        
        guard let foregroundConstraint = foregroundTopConstraint else {
            fatalError("set identifier")
        }
        
        foregroundView.layer.anchorPoint = CGPoint.init(x: 0.5, y: 1)
        foregroundConstraint.constant += foregroundView.bounds.height / 2
        self.contentView.bringSubviewToFront(foregroundView)
    }
}

// MARK: RotatedView

public class FavoriteCellView: UIView {
    var hiddenAfterAnimation = false
    var backView: FavoriteCellView?
    
    func addBackView(height: CGFloat, color:UIColor) {
        let view                                       = FavoriteCellView(frame: CGRect.zero)
        view.backgroundColor                           = color
        view.layer.anchorPoint                         = CGPoint.init(x: 0.5, y: 1)
        view.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(view)
        backView = view
        
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: nil,attribute: .Height,
            multiplier: 1, constant: height))
        
        self.addConstraints([
            NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1,
                constant: self.bounds.size.height - height + height / 2),
            NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading,
                multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing,
                multiplier: 1, constant: 0)
            ])
    }
}
