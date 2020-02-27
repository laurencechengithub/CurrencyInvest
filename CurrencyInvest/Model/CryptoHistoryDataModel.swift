//
//  CryptoHistoryDataModel.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/5/17.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import SwiftyJSON



struct CryptoHistoryDataModel {
    
    let historyData:[HistoryData]
    
    init(fromJson json:JSON) {
        self.historyData = json.arrayValue.map({
                HistoryData(fromJson: $0)
        })
    }
    
}

struct HistoryData {
    
    let low, average: Double
    let time: String
    let open, high: Double
    
    init(fromJson json:JSON) {
        self.low = json["low"].doubleValue
        self.average = json["average"].doubleValue
        self.time = json["time"].stringValue
        self.open = json["open"].doubleValue
        self.high = json["high"].doubleValue
    }
    
}
