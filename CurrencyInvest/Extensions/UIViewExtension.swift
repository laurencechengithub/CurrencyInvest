//
//  UIViewExtension.swift
//  re
//
//  Created by Hsiao Wind on 2017/4/24.
//  Copyright © 2017年 Re Corporation Limited. All rights reserved.
//

import UIKit

extension UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            // Fallback on earlier versions
            let rect: CGRect = self.frame
            
            UIGraphicsBeginImageContext(rect.size)
            let context: CGContext = UIGraphicsGetCurrentContext()!
            self.layer.render(in: context)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return img!
        }
    }
    
    func errorShake() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.25, initialSpringVelocity: 1, options: [.curveLinear], animations: {
            self.center.x -= 10
            self.layer.borderWidth = 3
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.cornerRadius = 10
        }, completion: { (isCompleted) in
        })
        UIView.animate(withDuration: 0.3, delay: 0.15, usingSpringWithDamping: 0.25, initialSpringVelocity: 1, options: [.curveLinear], animations: {
            self.center.x += 20
        }, completion: { (isCompleted) in
        })
        UIView.animate(withDuration: 0.3, delay: 0.225, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.25, options: [.curveLinear], animations: {
            self.center.x -= 10
        }, completion: { (isComleted) in
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.cornerRadius = 0
        })
    }
    
}

extension UIView {

    func fillSuperview() {

        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)

    }

    func anchorFrame(top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo:topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: leading).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true

    }
    
    func anchorSize(to view: UIView) {

        translatesAutoresizingMaskIntoConstraints = false
        
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

        
    }

    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

}
