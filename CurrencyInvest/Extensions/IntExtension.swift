//
//  IntExtension.swift
//  re
//
//  Created by Hsiao Wind on 2017/4/28.
//  Copyright © 2017年 Re Corporation Limited. All rights reserved.
//

import Foundation

extension Int {
//    func toCustomCurrencyStyle() -> String {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//
//        return "\(CurrencyUtility.getCurrencySymbol()) \(formatter.string(from: NSNumber(integerLiteral: self)) ?? "")!)"
//    }
}

struct Number {
    static let formatterWithSepator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Double {
    var stringFormatedWithSepator: String {
        return Number.formatterWithSepator.string(from: NSNumber(floatLiteral : self
        )) ?? ""
    }
}

extension BinaryInteger {
    var stringFormatedWithSepator: String {
        return Number.formatterWithSepator.string(from: NSNumber(integerLiteral: Int(self))) ?? ""
    }
    
    var kPointFormatted: String {
        let kNum = self / 1000
        let underKNum = self % 1000
        var newNumString = "\(self)"
        if self > 1000 && self < 1000000 {
            newNumString = "\(kNum).\(underKNum)k"
        }else if self > 1000000 {
            newNumString = "\(self / 1000000).\(self % 1000000)m"
        }
        return newNumString
    }
}
