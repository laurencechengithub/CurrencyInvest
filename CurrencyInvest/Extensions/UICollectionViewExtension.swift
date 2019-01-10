//
//  UICollectionViewExtension.swift
//  re
//
//  Created by Ken Chang on 2018/5/9.
//  Copyright © 2018年 Re Corporation Limited. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func reloadWithoutAnimation(){
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        self.reloadData()
        CATransaction.commit()
    }
}
