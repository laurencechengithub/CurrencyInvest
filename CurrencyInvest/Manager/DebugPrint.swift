//
//  DebugPrint.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/4/8.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation

func dPrint(_ item: Any..., function: String = #function) {
    #if DEBUG
    print("\(function): \(item)")
    #endif
}
