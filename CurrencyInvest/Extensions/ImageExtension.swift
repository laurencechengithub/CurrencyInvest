//
//  ImageExtension.swift
//  re
//
//  Created by Hsiao Wind on 2017/4/20.
//  Copyright © 2017年 Re Corporation Limited. All rights reserved.
//

import Foundation
import UIKit

// Use FontIcon as Image
//public extension UIImage {
//    public convenience init?(text: ReFont, fontSize: CGFloat, imageSize: CGSize = CGSize.zero, imageColor: UIColor = UIColor.black) {
//        guard let iconfont = UIFont.iconfont(ofSize: fontSize) else {
//            self.init()
//            return nil
//        }
//        var imageRect = CGRect(origin: CGPoint.zero, size: imageSize)
//        if __CGSizeEqualToSize(imageSize, CGSize.zero) {
//            imageRect = CGRect(origin: CGPoint.zero, size: text.rawValue.size(withAttributes: [NSAttributedString.Key.font: iconfont]))
//        }
//        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, UIScreen.main.scale)
//        defer {
//            UIGraphicsEndImageContext()
//        }
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.alignment = NSTextAlignment.center
//        text.rawValue.draw(in: imageRect, withAttributes: [NSAttributedString.Key.font : iconfont, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: imageColor])
//        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
//            self.init()
//            return nil
//        }
//        self.init(cgImage: cgImage)
//    }
//}

// MARK: Color Image

extension UIImage {
    func transform(withNewColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        context.clip(to: rect, mask: cgImage!)
        
        color.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UIImage {
    class func circle(diameter: CGFloat, color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        
        let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        ctx.setFillColor(color.cgColor)
        ctx.fillEllipse(in: rect)
        
        ctx.restoreGState()
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return img
    }
}

extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

