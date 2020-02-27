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
    
    var btcHistoryCompleteHandler:((Bool)->())!
    var ethHistoryCompleteHandler:((Bool)->())!
    var ltcHistoryCompleteHandler:((Bool)->())!
    var xmrHistoryCompleteHandler:((Bool)->())!
    var xrpHistoryCompleteHandler:((Bool)->())!
    var zecHistoryCompleteHandler:((Bool)->())!
    
    var currencyData:CurrencyDataModel!
    var cryptoDataModel:CryptoDataModel!
    var allCryptoPrice = [Double]()
    var allCryptoType = [String]()
    var cryptohistoryDataModel:CryptoHistoryDataModel!
    var historyDataArray = [HistoryData]()
    let dateFormatter = DateFormatter()
    
    func getQuotes() {
        
        RequestManager.sharedInstance.getCurrecyRate { (data) in
            self.currencyData = data
            
            //更新 masterQuotes
            UserDefualtManager.sharedInstance.masterQuotes = data.quotes
            
            self.quotesCompleteHandler(true)

        }
        
    }
//    
//    func getBitPrice() {
//        
//        RequestManager.sharedInstance.getBitCoinData { (data) in
//            
//            self.cryptoDataModel = data
//            UserDefualtManager.sharedInstance.localBitPrice = self.cryptoDataModel.ask
//            self.allCryptoPrice.append(self.cryptoDataModel.ask)
//            self.allCryptoType.append(coinType.bit.rawValue)
//
//            self.bitCompleteHandler(true)
//        }
//        
//    }
//    
//    func getEthPrice() {
//        RequestManager.sharedInstance.getEthCoinData { (data) in
//            self.cryptoDataModel = data
//            UserDefualtManager.sharedInstance.localEthPrice = self.cryptoDataModel.ask
//            self.allCryptoPrice.append(self.cryptoDataModel.ask)
//            self.allCryptoType.append(coinType.eth.rawValue)
//            self.ethCompleteHandler(true)
//        }
//    }
//    
//    func getLTCPrice() {
//        
//        RequestManager.sharedInstance.getLTCCoinData { (data) in
//            self.cryptoDataModel = data
//            UserDefualtManager.sharedInstance.localLTCPrice = self.cryptoDataModel.ask
//            self.allCryptoPrice.append(self.cryptoDataModel.ask)
//            self.allCryptoType.append(coinType.ltc.rawValue)
//            self.ltcCompleteHandler(true)
//            
//        }
//        
//    }
//    
//    func getXMRPrice() {
//        
//        RequestManager.sharedInstance.getXMRCoinData { (data) in
//            self.cryptoDataModel = data
//            UserDefualtManager.sharedInstance.localXMRPrice = self.cryptoDataModel.ask
//            self.allCryptoPrice.append(self.cryptoDataModel.ask)
//            self.allCryptoType.append(coinType.xmr.rawValue)
//            self.xmrCompleteHandler(true)
//            
//        }
//        
//    }
//    
//    func getXRPPrice() {
//        
//        RequestManager.sharedInstance.getXRPCoinData { (data) in
//            self.cryptoDataModel = data
//            UserDefualtManager.sharedInstance.localXRPPrice = self.cryptoDataModel.ask
//            self.allCryptoPrice.append(self.cryptoDataModel.ask)
//            self.allCryptoType.append(coinType.xrp.rawValue)
//            self.xrpCompleteHandler(true)
//            
//        }
//        
//    }
//    
//    func getZECPrice() {
//        
//        RequestManager.sharedInstance.getZECCoinData { (data) in
//            self.cryptoDataModel = data
//            UserDefualtManager.sharedInstance.localZECPrice = self.cryptoDataModel.ask
//            self.allCryptoPrice.append(self.cryptoDataModel.ask)
//            self.allCryptoType.append(coinType.zec.rawValue)
//            self.zecCompleteHandler(true)
//            
//        }
//        
//    }
    
//
    func saveDataToUserDefault() {

        UserDefualtManager.sharedInstance.localCryptoPriceArray = self.allCryptoPrice
        UserDefualtManager.sharedInstance.localCryptoTypeArray = self.allCryptoType

    }
    
//
//    func requestCryptoHistoryFor(type:CrytoType, completeHandler: @escaping ([HistoryData])->()) {
//
//        var historyDataArr = [HistoryData]()
//        RequestManager.sharedInstance.getHistoryFor(cryptoName: type) { (data) in
//
//                self.cryptohistoryDataModel = data
//                guard let cryptohistoryDataModel = self.cryptohistoryDataModel else {
//                    return
//                }
//                _ = cryptohistoryDataModel.historyData.map({
//
//                    //String格式的時間
//                    let givenTime = $0.time
//
//                    // 將String轉換為date格式
//                    self.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                    guard let filterTime = self.dateFormatter.date(from: givenTime) else {
//                        return
//                    }
//
//                    self.dateFormatter.dateFormat = "HH:mm:ss"
//                    let result = self.dateFormatter.string(from: filterTime)
//                    // 篩選 時間為 23:00:00 避免一天有24筆
//                    if result == "23:00:00" {
//                        historyDataArr.append($0)
//                    }
//                })
//                completeHandler(historyDataArr)
//        }
//
//
//
//    }
    
    
//    func getBTCHistory() {
//        
//        self.requestCryptoHistoryFor(type: .BTC) { (historyData) in
//
//            self.historyDataArray = historyData
//            for data in self.historyDataArray {
//                Global.historyBTCValue.append(data.average)
//            }
//            self.btcHistoryCompleteHandler(true)
//        }
//        
//    }
//    
//    func getETHHistory() {
//    
//        self.requestCryptoHistoryFor(type: .ETH) { (historyData) in
//            self.historyDataArray = historyData
//            for data in self.historyDataArray {
//                Global.historyETHValue.append(data.average)
//            }
//            self.ethHistoryCompleteHandler(true)
//        }
//   
//    }
//   
//    func getLTCHistory() {
//        
//        self.requestCryptoHistoryFor(type: .LTC) { (historyData) in
//            self.historyDataArray = historyData
//             for data in historyData {
//                  Global.historyLTCValue.append(data.average)
//              }
//        self.ltcHistoryCompleteHandler(true)
//        }
//        
//    }
//    
//    func getXMRHistory() {
//         
//        self.requestCryptoHistoryFor(type: .XMR) { (historyData) in
//            self.historyDataArray = historyData
//            for data in historyData {
//                Global.historyXMRValue.append(data.average)
//            }
//            self.xmrHistoryCompleteHandler(true)
//        }
//     
//     }
//    
//    func getXRPHistory() {
//        
//        self.requestCryptoHistoryFor(type: .XRP) { (historyData) in
//            self.historyDataArray = historyData
//            for data in historyData {
//                Global.historyXRPValue.append(data.average)
//            }
//            self.xrpHistoryCompleteHandler(true)
//        }
//    }
//    
//    func getZECHistory() {
//        
//        self.requestCryptoHistoryFor(type: .ZEC) { (historyData) in
//            self.historyDataArray = historyData
//            for data in historyData {
//               Global.historyZECValue.append(data.average)
//            }
//            self.zecHistoryCompleteHandler(true)
//        }
//    }
    
}


