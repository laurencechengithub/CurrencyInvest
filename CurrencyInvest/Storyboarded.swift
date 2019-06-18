//
//  Storyboarded.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/6/11.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardedProtocol {
    static func instantiate() -> Self
}

extension StoryboardedProtocol where Self : UIViewController {

    static func instantiate() -> Self {

        let id = String(describing: self)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return mainStoryboard.instantiateViewController(withIdentifier: id) as! Self
    }

}
