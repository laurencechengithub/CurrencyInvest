//
//  BitCoinDataModel.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/2/26.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import SwiftyJSON

struct BitCoinDataModel {
    let ask, bid, last, high: Double
    let low: Double
    let open: Open
    let averages: Averages
    let volume: Double
    let changes: Changes
    let volumePercent: Double
    let timestamp: Int
    let displayTimestamp: String
    
    
    init(fromJson json:JSON) {
        
        self.ask = json["ask"].doubleValue
        self.bid = json["bid"].doubleValue
        self.last = json["last"].doubleValue
        self.high = json["high"].doubleValue
        self.low = json["low"].doubleValue
        self.open = Open(fromJson: json["open"])
        self.averages = Averages(fromJson: json["averages"])
        self.volume = json["volume"].doubleValue
        self.changes = Changes(fromJson: json["changes"])
        self.volumePercent = json["volume_Percent"].doubleValue
        self.timestamp = json["timestamp"].intValue
        self.displayTimestamp = json["display_timestamp"].stringValue
    }
    
    
}

struct Averages {
    let daily, weekly, monthly: Double
    
    init(fromJson json:JSON) {
        self.daily = json["daily"].doubleValue
        self.weekly = json["weekly"].doubleValue
        self.monthly = json["monthly"].doubleValue
    }
}

struct Changes {
    let price, percent: Averages
    
    init(fromJson json:JSON) {
        self.price = Averages(fromJson: json["price"])
        self.percent = Averages(fromJson: json["percent"])
    }
}

struct Open {
    let day, week, month: String
    
    init(fromJson json:JSON) {
        self.day = json["day"].stringValue
        self.week = json["week"].stringValue
        self.month = json["month"].stringValue
    }
}

