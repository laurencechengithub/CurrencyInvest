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
    var ltcCompleteHandler:((Bool)->())!
    var xmrCompleteHandler:((Bool)->())!
    var xrpCompleteHandler:((Bool)->())!
    var zecCompleteHandler:((Bool)->())!
    var currencyData:CurrencyDataModel!
    var cryptoDataModel:CryptoDataModel!
    var allCryptoPrice = [Double]()
    var allCryptoType = [String]()
    
    func getQuotes() {
        
        RequestManager.sharedInstance.getCurrecyRate { (data) in
            self.currencyData = data
            
            //更新 masterQuotes
            UserDefualtManager.sharedInstance.masterQuotes = data.quotes
            
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
    
    func getLTCPrice() {
        
        RequestManager.sharedInstance.getLTCCoinData { (data) in
            self.cryptoDataModel = data
            UserDefualtManager.sharedInstance.localLTCPrice = self.cryptoDataModel.ask
            self.allCryptoPrice.append(self.cryptoDataModel.ask)
            self.allCryptoType.append(coinType.ltc.rawValue)
            self.ltcCompleteHandler(true)
            
        }
        
    }
    
    func getXMRPrice() {
        
        RequestManager.sharedInstance.getXMRCoinData { (data) in
            self.cryptoDataModel = data
            UserDefualtManager.sharedInstance.localXMRPrice = self.cryptoDataModel.ask
            self.allCryptoPrice.append(self.cryptoDataModel.ask)
            self.allCryptoType.append(coinType.xmr.rawValue)
            self.xmrCompleteHandler(true)
            
        }
        
    }
    
    func getXRPPrice() {
        
        RequestManager.sharedInstance.getXRPCoinData { (data) in
            self.cryptoDataModel = data
            UserDefualtManager.sharedInstance.localXRPPrice = self.cryptoDataModel.ask
            self.allCryptoPrice.append(self.cryptoDataModel.ask)
            self.allCryptoType.append(coinType.xrp.rawValue)
            self.xrpCompleteHandler(true)
            
        }
        
    }
    
    func getZECPrice() {
        
        RequestManager.sharedInstance.getZECCoinData { (data) in
            self.cryptoDataModel = data
            UserDefualtManager.sharedInstance.localZECPrice = self.cryptoDataModel.ask
            self.allCryptoPrice.append(self.cryptoDataModel.ask)
            self.allCryptoType.append(coinType.zec.rawValue)
            self.zecCompleteHandler(true)
            
        }
        
    }
    
    
    func saveDataToUserDefault() {
        
        UserDefualtManager.sharedInstance.localCryptoPriceArray = self.allCryptoPrice
        UserDefualtManager.sharedInstance.localCryptoTypeArray = self.allCryptoType
        
    }
    
    
    
}
