//
//  BitCoinViewModel.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/2/26.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation

class BitCoinViewModel {
    
    var cryptohistoryDataModel:CryptoHistoryDataModel!
    var historyDataArray = [HistoryData]()
    
//    func getHistoryFor(crytoType:CrytoType,completeHandler: @escaping (Bool)->()) {
//
//        let dateFormatter = DateFormatter()
//
//        RequestManager.sharedInstance.getHistoryFor(cryptoName: crytoType) { (data) in
//
//            self.cryptohistoryDataModel = data
//            guard let cryptohistoryDataModel = self.cryptohistoryDataModel else {
//                completeHandler(false)
//                return
//            }
//
////            historyDataModel.historyData.count
//            _ = cryptohistoryDataModel.historyData.map({
//
//                let givenTime = $0.time
////                print("givenTime : \(givenTime)")
//
//                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                guard let filterTime = dateFormatter.date(from: givenTime) else {
//                    return
//                }
////                print("filterTime : \(filterTime)")
//
//                dateFormatter.dateFormat = "HH:mm:ss"
//                let result = dateFormatter.string(from: filterTime)
////                print("result : \(result)")
//                if result == "23:00:00" {
//                    self.historyDataArray.append($0)
//                }
//            })
//
//            _ = self.historyDataArray.map({
//
//                    switch crytoType{
//
//                    case .BTC:
//                        Global.historyBTCValue.append($0.average)
//                    case .ETH:
//                        Global.historyETHValue.append($0.average)
//                    case .LTC:
//                        Global.historyLTCValue.append($0.average)
//                    case .XMR:
//                        Global.historyXMRValue.append($0.average)
//                    case .XRP:
//                        Global.historyXRPValue.append($0.average)
//                    case .ZEC:
//                        Global.historyZECValue.append($0.average)
//                    }
//            })
//
//            completeHandler(true)
//        }
//
//    }
    
}
