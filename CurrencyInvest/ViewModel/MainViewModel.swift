//
//  MainViewModel.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/1/1.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation

class MainViewModel {
    
    var quotesLoadCompleteHandler:((Bool)->())!
    var currencyData:CurrencyDataModel!
    var currencyQuotes = [String:Double]()
    var currencyKeys = [String]()
    
    func getQuotes() {
        
        
        RequestManager.sharedInstance.getCurrecyRate { (completeHandlerData) in
            self.currencyData = completeHandlerData
            self.currencyQuotes = completeHandlerData.quotes
            
            UserDefualtManager.sharedInstance.localQuote = self.currencyQuotes
            
            // suffix 取從string後面數來第三位
            self.currencyKeys = self.currencyQuotes.map () {
                String($0.key.suffix(3))
            }
            // abc排序
            self.currencyKeys = self.currencyKeys.sorted(by: {$0 < $1})
            print(self.currencyKeys)
            
            self.quotesLoadCompleteHandler(true)
            
//            DispatchQueue.main.sync(execute: {
//                vc.currencyPicker.reloadAllComponents()
//            })
            
            
        }
    }
    
    
    
    
    func calculate (OneAmount:Double,oneRate:Double,rtnRate:Double) -> Double{
        
        let OneAmountToUSD = OneAmount/oneRate
        let returnAmount = OneAmountToUSD * rtnRate
        
        return returnAmount
    
    }
}

