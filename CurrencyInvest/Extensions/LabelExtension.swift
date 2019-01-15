//
//  LabelExtension.swift
//  re
//
//  Created by 李承儒 on 2017/4/11.
//  Copyright © 2017年 Re Corporation Limited. All rights reserved.
//

import Foundation
import UIKit
import DeviceKit

extension UILabel {
    func setFontSizeByDevice(size: CGFloat) {
      let device = Device()
        
        if device.isOneOf(CurrentDevice.iPhone4Inch_devices) {
            self.font = self.font.withSize(size - 2)
        } else {
            self.font = self.font.withSize(size)
        }
    }
    
    func changeDecimalFontSizeBigger(withColor color: UIColor? = nil) {
        let separatedByPointStringArray = self.text!.components(separatedBy: ".")
        
        guard separatedByPointStringArray[0] != "0" && separatedByPointStringArray.count > 1 else { return }
        
        let nsStringText = (self.text! as NSString)
        
        var range = nsStringText.range(of: ".")
        
        range.length = nsStringText.length - range.location
        
        let originFont = self.font!
        let originColor = self.textColor
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: originFont,
            NSAttributedString.Key.foregroundColor: color ?? originColor!
        ]
        
        let smallAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: originFont.withSize(self.font.pointSize * 2 / 3),
            NSAttributedString.Key.foregroundColor: color ?? originColor!
        ]
        
        let attributedString = NSMutableAttributedString(string: self.text!, attributes: normalAttributes)
        attributedString.setAttributes(smallAttributes, range: range)
        
        self.attributedText = attributedString
    }
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
    
    func heightForLabel(text:String, font:UIFont, width: CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    
    
}

class CurrentDevice {
    static let iPhone4Inch_devices: [Device] = [.iPhone5,.iPhoneSE,.iPhone5s,.iPhone5c,
                                                .simulator(.iPhone5),.simulator(.iPhoneSE),.simulator(.iPhone5s),.simulator(.iPhone5c)]
    
    static let iPhone4_7Inch_devices: [Device] = [.iPhone6,.iPhone6s,.iPhone7,.simulator(.iPhone6),.simulator(.iPhone6s),.simulator(.iPhone7)]
    
    
    static let iPhone5_5Inch_devices:[Device] = [.iPhone6Plus,.iPhone6sPlus,.iPhone7Plus,.simulator(.iPhone6Plus),.simulator(.iPhone6sPlus),.simulator(.iPhone7Plus)]
}
