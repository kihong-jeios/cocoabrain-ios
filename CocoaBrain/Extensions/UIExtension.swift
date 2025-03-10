//
//  UIExtension.swift
//  CocoaBrain
//
//  Created by Kai on 2/26/25.
//

import UIKit

let k320: CGFloat = UIScreen.main.bounds.size.width
let k480: CGFloat = UIScreen.main.bounds.size.height

func image(from color: UIColor, size: CGSize = CGSize(width: 100, height: 100)) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    UIRectFill(CGRect(origin: .zero, size: size))
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image ?? UIImage()
}

extension UIView {
    
    func addBorder(borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    func takeScreenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
    
    @objc func setShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.8
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.masksToBounds = false
    }
    
    @objc func setShadow(x: CGFloat, y: CGFloat, blur: CGFloat, color: UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = blur
        self.layer.shadowOffset = CGSize(width: x, height: y)
        self.layer.masksToBounds = false
    }
    
    @objc func setEditTCBoxButtonShadow(){
        self.layer.shadowColor = UIColor(red: 0.251, green: 0.431, blue: 0.518, alpha: 0.16).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = false
    }
    
    var theCornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            if newValue > 0.0 {
                self.clipsToBounds = true
            }
            else {
                self.clipsToBounds = false
            }
        }
    }
    
    var theBorderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    var theBorderColor: UIColor? {
        get {
            if let color = self.layer.borderColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
        set {
            if let color = newValue {
                self.layer.borderColor = color.cgColor
            }
            else {
                self.layer.borderColor = nil
            }
        }
    }
    
    func addBlur(style: UIBlurEffect.Style, _ alpha: CGFloat = 0.5) {
        let effect = UIBlurEffect(style: style)
        let effectView = UIVisualEffectView(effect: effect)
        
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha
        
        self.addSubview(effectView)
    }
    
    var safeAreaHeight: CGFloat {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.layoutFrame.size.height
        }
        return bounds.height
    }

    fileprivate var allViews: [UIView] {
        var views = [self]
        subviews.forEach {
            views.append(contentsOf: $0.allViews)
        }
        
        return views
    }
    
    enum BorderPosition {
        case top, bottom, left, right
    }
    
    func addBorder(to side: BorderPosition, color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        switch side {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
        case .right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
        }
        
        self.layer.addSublayer(border)
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundTopCorners(radius: CGFloat) {
        roundCorners([.topLeft, .topRight], radius: radius)
    }
}


typealias ReusableViewRefresh = (section: Int, del: [Int], ins: [Int], mod: [Int])

protocol ReusableView: AnyObject {}
extension ReusableView where Self: UIView {
  static var reuseIdentifier: String { return String(describing: self) }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
