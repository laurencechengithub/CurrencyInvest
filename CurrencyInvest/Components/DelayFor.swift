//
//  DelayFor.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/5/6.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation

/// This is global-wide function
///
/// - Parameters:
///   - seconds: how long you want to delay in seconds
///   - completion: after delay block

func delayFor(seconds: Double, completion: @escaping () -> ()) {
    let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
    
    DispatchQueue.main.asyncAfter(deadline: popTime) {
        completion()
    }
}
