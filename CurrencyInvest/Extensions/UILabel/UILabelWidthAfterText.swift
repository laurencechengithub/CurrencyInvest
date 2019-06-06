//
//  UILabelWidthAfterText.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/4/15.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func WidthForLabelWith(text:String, font:UIFont, height: CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
        label.numberOfLines = 1
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.width
    }
}
