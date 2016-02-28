

import UIKit

public class FoldingCell: UITableViewCell {
  
  public typealias CompletionHandler = () -> Void
  
  @IBOutlet weak public var foregroundView: RotatedView!
  var animationView: UIView?
  
  @IBInspectable public var itemCount: NSInteger = 2 //count of folding
  
  @IBInspectable public var backViewColor: UIColor = UIColor.brownColor()
  
  var animationItemViews: [RotatedView]?
  
  public enum AnimationType {
    case Open
    case Close
  }
  
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
    foregroundView.layer.transform = foregroundView.transform3d()
    
    //createAnimationView();
    self.contentView.bringSubviewToFront(foregroundView)
  }
  
  func createAnimationItemView()->[RotatedView] {
    guard let animationView = self.animationView else {
      fatalError()
    }
    
    var items = [RotatedView]()
    items.append(foregroundView)
    var rotatedViews = [RotatedView]()
    for case let itemView as RotatedView in animationView.subviews.filter({$0 is RotatedView}).sort({ $0.tag < $1.tag }){
      rotatedViews.append(itemView)
      if let backView = itemView.backView {
        rotatedViews.append(backView)
      }
    }
    items.appendContentsOf(rotatedViews)
    return items
  }
  
}


// MARK: RotatedView

public class RotatedView: UIView {
  var hiddenAfterAnimation = false
  var backView: RotatedView?
  
  func addBackView(height: CGFloat, color:UIColor) {
    let view                                       = RotatedView(frame: CGRect.zero)
    view.backgroundColor                           = color
    view.layer.anchorPoint                         = CGPoint.init(x: 0.5, y: 1)
    view.layer.transform                           = view.transform3d()
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


extension RotatedView {
  
  func rotatedX(angle : CGFloat) {
    var allTransofrom    = CATransform3DIdentity;
    let rotateTransform  = CATransform3DMakeRotation(angle, 1, 0, 0)
    allTransofrom        = CATransform3DConcat(allTransofrom, rotateTransform)
    allTransofrom        = CATransform3DConcat(allTransofrom, transform3d())
    self.layer.transform = allTransofrom
  }
  
  func transform3d() -> CATransform3D {
    var transform = CATransform3DIdentity
    transform.m34 = 2.5 / -2000;
    return transform
  }
  
  // MARK: animations
  
  func foldingAnimation(timing: String, from: CGFloat, to: CGFloat, duration: NSTimeInterval, delay:NSTimeInterval, hidden:Bool) {
    
    let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.x")
    rotateAnimation.timingFunction      = CAMediaTimingFunction(name: timing)
    rotateAnimation.fromValue           = (from)
    rotateAnimation.toValue             = (to)
    rotateAnimation.duration            = duration
    rotateAnimation.delegate            = self;
    rotateAnimation.fillMode            = kCAFillModeForwards
    rotateAnimation.removedOnCompletion = false;
    rotateAnimation.beginTime           = CACurrentMediaTime() + delay
    
    self.hiddenAfterAnimation = hidden
    
    self.layer.addAnimation(rotateAnimation, forKey: "rotation.x")
  }
  
  override public func animationDidStart(anim: CAAnimation) {
    self.layer.shouldRasterize = true
    self.alpha = 1
  }
  
  override public func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    if hiddenAfterAnimation {
      self.alpha = 0
    }
    self.layer.removeAllAnimations()
    self.layer.shouldRasterize = false
    self.rotatedX(CGFloat(0))
  }
}

extension UIView {
  func pb_takeSnapshot(frame: CGRect) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
    
    let context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, frame.origin.x * -1, frame.origin.y * -1)
    
    guard let currentContext = UIGraphicsGetCurrentContext() else {
      return nil
    }
    
    self.layer.renderInContext(currentContext)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
  }
}