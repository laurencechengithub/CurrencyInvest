//
//  CollectionViewPassThroughGestrue.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/4/23.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import UIKit

class TapThroughCollectionView : UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let hitView = super.hitTest(point, with: event)
        
        if(hitView == self){
            return nil
        }
        return hitView
    }
    
    
}

