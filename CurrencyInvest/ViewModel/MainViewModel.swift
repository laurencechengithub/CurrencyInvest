//
//  MainViewModel.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/1/1.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import UIKit

class MainViewModel {
    
    private var quotes = UserDefualtManager.sharedInstance.localQuote

    func getQuotesKey() -> [String] {
        
        var keys = [String]()
        
        // suffix 取從string後面數來第三位
        keys = self.quotes.map () {
            String($0.key.suffix(3))
        }
        // abc排序
        keys = keys.sorted(by: {$0 < $1})
        print(keys)
        
        return keys
    }
    
    func getQuotes() -> [String:Double] {
                
        return quotes
    }
    
    
    func calculateWith (textField: UITextField, inRate:Double, outRate:Double ) -> Double {
        
        if let qty = textField.text {
            let inAmount = Double(qty) ?? 0
            let inAmountToUSD = inAmount/inRate
            let returnAmount = inAmountToUSD * outRate
            
            return returnAmount
        } else {
            return 0
        }

    }
    
    func calculateUSD (textField: UITextField, inRate:Double) {
        
        guard let text = textField.text else {
            print("text is nil")
            return
        }
        let textIntoDouble = Double(text)
        GlobalTempValue.amountUSD = textIntoDouble ?? 0
        
    }
    
    
//    func reloadTextWith (outTextField:UITextField, amount:Double, inRate:Double) {
//
//        if let input = outTextField.text {
//            let amountt = Double(input) ?? 0
//            let double = calculateWith(inAmount: amountt, inRate: <#T##Double#>, outRate: <#T##Double#>)
//            let string = String(double)
//            outTextField.text = string
//        }
//
//
//    }
    
}

