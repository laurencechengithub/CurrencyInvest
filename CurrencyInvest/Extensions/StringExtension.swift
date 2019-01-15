//
//  StringExtension.swift
//  re
//
//  Created by Hsiao Wind on 2017/4/20.
//  Copyright © 2017年 Re Corporation Limited. All rights reserved.
//

import Foundation
import UIKit


extension String {
    
//    var localized: String {
//        
//        return localize(stringKey: self)
//        
//    }
//    
//    func splitByLength(_ length: Int) -> [String] {
//        var result = [String]()
//        var collectedCharacters = [Character]()
//        collectedCharacters.reserveCapacity(length)
//        var count = 0
//        
//        for character in self.charactersArray {
//            collectedCharacters.append(character)
//            count += 1
//            if (count == length) {
//                // Reached the desired length
//                count = 0
//                result.append(String(collectedCharacters))
//                collectedCharacters.removeAll(keepingCapacity: true)
//            }
//        }
//        
//        // Append the remainder
//        if !collectedCharacters.isEmpty {
//            result.append(String(collectedCharacters))
//        }
//        
//        return result
//    }
    
    func rect(withFont font: UIFont, size: CGSize) -> CGRect {
        return (self as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    }
    
    func height(withFont font: UIFont, size: CGSize) -> CGFloat {
        return self.rect(withFont: font, size: size).height
    }
    
    func width(withFont font: UIFont, size: CGSize) -> CGFloat {
        return self.rect(withFont: font, size: size).width
    }
    
//    func localize(stringKey: String) -> String {
//
//        guard let languagePack = UserdefaultsManager.sharedInstance.preferLanguage else {
//            assertionFailure("Missing translation for: \(stringKey)")
//            return ""
//        }
        
//        let str:String = LocalizeUtility.sharedInstance.getLangString(withKey: stringKey, withLocalizationFileNmae: languagePack.langFileName.rawValue)
        
//        let str:String = LocalizeUtility.sharedInstance.getLangString(withKey: stringKey, withLocalizationFileNmae:LanguageUtility.getSupportLangFileName())
//
//        return str
//    }
    
    //取得差距天數
    func dayLeft() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date:Date = dateFormatter.date(from: self)!
        
        let now:Date = Date()

        let calendar = NSCalendar.current
        let unitFlags = Set<Calendar.Component>([.day, .month, .year, .hour])
        let anchorComponents = calendar.dateComponents(unitFlags, from: now,  to: date)
        
        //let timeDifference = "\(anchorComponents.year)" + "年" + "\(anchorComponents.month)" + "個月"
        //let timeDifferences =  + "\(anchorComponents.day)" + "天"
        
        if let date = anchorComponents.day{
            
            return (date < 1) ? "1" : "\(date)"

        }
        
      return "1"
        
    }
    
    //判斷數字
    func isNumber() -> Bool {
        
        var result = ""

        let pattern1 = "^[0-9]*$"
        
        let regex1 = try! NSRegularExpression(pattern: pattern1, options: NSRegularExpression.Options.caseInsensitive)
        let res = regex1.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count))
        
        for checkingRes in res {
            result = result + (self as NSString).substring(with: checkingRes.range)
        }
        
        if result == self{
            return true
        }else{
            return false
        }

    }
    
    func stringWithCurrencySymbol() -> NSAttributedString {
        
        let stringAttributes: [NSAttributedString.Key : Any] = [
            .font : UIFont.systemFont(ofSize: 12.0)
        ]
        
        let string1 = NSAttributedString(string: "\(self)")

        let string2 = NSAttributedString(string: "$", attributes: stringAttributes)
        
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(string1)
        mutableAttributedString.append(string2)
        
        return mutableAttributedString
        
    }
}
