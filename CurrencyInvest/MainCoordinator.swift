//
//  Coordinator.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/6/11.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import UIKit

protocol CoordinatorProtocol:class {
    var childCoordinators:[MainCoordinator] { get set }
    var navigationController:UINavigationController { get set }
    func start()
}

class MainCoordinator: CoordinatorProtocol{
    var childCoordinators = [MainCoordinator]()
    var navigationController: UINavigationController
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let entryVC = EntryViewViewController.instantiate()
        entryVC.mainCoordinator = self
        navigationController.pushViewController(entryVC, animated: true)
        
    }
    
    func toCurrency() {
        
        let currencyVC = CurrencyViewController.instantiate()
        currencyVC.mainCoordinator = self
        navigationController.pushViewController(currencyVC, animated: true)
    }
    
}
