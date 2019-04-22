//
//  UILabelHeightAfterText.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/4/15.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {

    func heightForLabelWith(text:String, font:UIFont, width: CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
}
