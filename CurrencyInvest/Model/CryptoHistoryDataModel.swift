//
//  CryptoHistoryDataModel.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/5/17.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import SwiftyJSON



struct CryptoHistoryDataModel: Codable {
    
    let low, average: Double
    let time: String
    let open, high: Double
    
//    init(fromJson json:JSON) {
//        self.low = json["low"].doubleValue
//        self.average = json["average"].doubleValue
//        self.time = json["time"].stringValue
//        self.open = json["open"].doubleValue
//        self.high = json["high"].doubleValue
//    }
    
}

struct historyData: Codable {

}
