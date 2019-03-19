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
    var bitCompleteHandler:((Bool)->())!
    var ethCompleteHandler:((Bool)->())!
    var currencyData:CurrencyDataModel!
    var cryptoDataModel:CryptoDataModel!
    var allCryptoPrice = [Double]()
    var allCryptoType = [String]()
    
    func getQuotes() {
        
        RequestManager.sharedInstance.getCurrecyRate { (data) in
            self.currencyData = data

            UserDefualtManager.sharedInstance.localQuote = data.quotes
            self.quotesCompleteHandler(true)

        }
        
    }
    
    func getBitPrice() {
        
        RequestManager.sharedInstance.getBitCoinData { (data) in
            
            self.cryptoDataModel = data
            UserDefualtManager.sharedInstance.localBitPrice = self.cryptoDataModel.ask
            self.allCryptoPrice.append(self.cryptoDataModel.ask)
            self.allCryptoType.append(coinType.bit.rawValue)

            self.bitCompleteHandler(true)
        }
        
    }
    
    func getEthPrice() {
        RequestManager.sharedInstance.getEthCoinData { (data) in
            self.cryptoDataModel = data
            UserDefualtManager.sharedInstance.localEthPrice = self.cryptoDataModel.ask
            self.allCryptoPrice.append(self.cryptoDataModel.ask)
            self.allCryptoType.append(coinType.eth.rawValue)
            self.ethCompleteHandler(true)
        }
    }
    
    func saveDataToUserDefault() {
        
        UserDefualtManager.sharedInstance.localCryptoPriceArray = self.allCryptoPrice
        UserDefualtManager.sharedInstance.localCryptoTypeArray = self.allCryptoType
        
    }
    
    
    
}
