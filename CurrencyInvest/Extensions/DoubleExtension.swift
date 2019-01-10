//
//  DoubleExtension.swift
//  re
//
//  Created by Ken Chang on 2018/8/16.
//  Copyright © 2018年 Re Corporation Limited. All rights reserved.
//

import Foundation

extension Double {
    
    func toDistanceString() -> String {
        let isLessThanTenKMeterAndNotZero = self < 10000 && self != 0
        
        var colorAttributedString: String {
            get {
                if isLessThanTenKMeterAndNotZero {
                    if self > 1000 {
                        let float: Float = Float(self) / 1000
                        let distanceString = String(format: "%.1f", float)
                        //return "距離 \(distanceString) 公里"
                        return "\(distanceString)km"
                    }else{
                        if self < 10 {
                            //return "距離 10 公尺 以內"
                            return "10m <"
                        }else{
                            //return "距離 \(distance) 公尺"
                            return "\(Int(self))m"
                        }
                    }
                }else{
                    if self == 0 {
                        return ""
                    }else{
                        //return "距離 10 公里 以外"
                        return "> 10km"
                    }
                }
            }
        }
        
        return colorAttributedString
        
    }
    
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let divisor = pow(10.0, Double(fractionDigits))
        return (self * divisor).rounded() / divisor
    }

}
