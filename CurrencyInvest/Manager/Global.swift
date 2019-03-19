//
//  Global.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/1/15.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation



struct Global {
    
    static var amountUSD = 0.0
    
    static var NameOne = UserDefualtManager.sharedInstance.localNameOne
    static var RateOne = UserDefualtManager.sharedInstance.localRateOne
    static var AmountOne = UserDefualtManager.sharedInstance.localAmountOne
    
    static var NameTwo = UserDefualtManager.sharedInstance.localNameOne
    static var RateTwo = UserDefualtManager.sharedInstance.localRateTwo
    static var AmountTwo = UserDefualtManager.sharedInstance.localAmountTwo
    
    static var NameThree = ""
    static var RateThree = 0.0
    static var AmountThree = 0.0
    
    static var isCurrencyPageShowing:Bool = true
    static var isBitCoinPageShlowing:Bool = false
}

enum coinType:String {
    case bit = "BTC"
    case eth = "ETH"
}
