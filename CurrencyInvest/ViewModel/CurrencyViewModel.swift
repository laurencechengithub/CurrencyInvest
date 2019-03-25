//
//  CurrencyViewModel.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/1/1.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import UIKit

class CurrencyViewModel {
    
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
    
    
    func calculateWith (inAmount: Double, inRate:Double, outRate:Double ) -> Double {
        
        if inRate == 0 || outRate == 0 {
            return 0
        } else {
            
            let inAmountToUSDAmount = inAmount/inRate //轉換美金
            let outAmount = inAmountToUSDAmount * outRate
            
            return outAmount
        }
        
    }

    func aaaa (inAmount: Double, inRate:Double, outRate:Double ) -> Double {
        
        if inRate == 0 || outRate == 0 {
            return 0
        } else {
            
            let inAmountToUSDAmount = inAmount/inRate //轉換美金
            let outAmount = inAmountToUSDAmount * outRate
            
            return outAmount
        }
        
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

