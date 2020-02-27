//
//  Global.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/1/15.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation



struct Global {
    
    static var selectedQuotes = [Double]()
    static var selectedNames = [String]()
    static var selectedAmounts = [Double]()
    static var allQuotes = [String:Double]()
    static var allNames = [String]()
    static var historyBTCValue = [Double]()
    static var historyETHValue = [Double]()
    static var historyLTCValue = [Double]()
    static var historyXMRValue = [Double]()
    static var historyXRPValue = [Double]()
    static var historyZECValue = [Double]()
    
    static var isCurrencyPageShowing:Bool = true
    static var isBitCoinPageShlowing:Bool = false
    static var isCoffeeBought:Bool = false
    static var isOffLineMode:Bool = false
    static var isToSetting:Bool = false

    static let alphabetArray = ["All","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    static var lastEnterAmount = Double()
    static var lastIndexPathRow = Int()

}

enum coinType:String {
    case bit = "BTC"
    case eth = "ETH"
    case ltc = "LTC"
    case xmr = "XMR"
    case xrp = "XRP"
    case zec = "ZEC"
}

enum CrytoType {
    case BTC
    case ETH
    case LTC
    case XMR
    case XRP
    case ZEC
    
    var string:String {
        get {
            switch self {
            case .BTC:
                return "BTCUSD"
            case .ETH:
                return "ETHUSD"
            case .LTC:
                return "LTCUSD"
            case .XMR:
                return "XMRUSD"
            case .XRP:
                return "XRPUSD"
            case .ZEC:
                return "ZECUSD"
            }
        }
    }
    static let allCrytoTypeValues = [BTC,ETH,LTC,XMR,XRP,ZEC]
    var count:Int {
        get {
            return CrytoType.allCrytoTypeValues.count
        }
    }
    
}
