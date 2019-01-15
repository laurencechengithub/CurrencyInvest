//
//  EntryViewViewModel.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/1/7.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation


class EntryViewViewModel {
    
    var quotesCompleteHandler:((Bool)->())!
//    var currencyData:CurrencyDataModel!
    
    func getQuotes() {
        
        RequestManager.sharedInstance.getCurrecyRate { (completeHandlerData) in
//            self.currencyData = completeHandlerData

            UserDefualtManager.sharedInstance.localQuote = completeHandlerData.quotes
            self.quotesCompleteHandler(true)

        }
    }
}
