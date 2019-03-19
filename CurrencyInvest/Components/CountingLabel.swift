//
//  CountingLabel.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/3/19.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import UIKit


class CountingLabel:UILabel {
    
    var startValue: Double
    var displayLink: CADisplayLink?
    var animationStartDate = Date()
    var endValue:Double
    var animateDuration:Double
    
    init(startValue:Double, endValue:Double, duration:Double) {
        self.startValue = startValue
        self.endValue = endValue
        self.animateDuration = duration
        super.init(frame: .zero)
        
        self.text = "\(startValue)"
        self.textAlignment = .center
        self.font = UIFont.boldSystemFont(ofSize: 40)
        self.textColor = UIColor.ciMaize
        self.backgroundColor = UIColor.clear
        
        displayLink = CADisplayLink(target: self, selector: #selector(handle))
        displayLink?.add(to: .main, forMode: .default)
        
    }
    
    @objc func handle() {
        
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animateDuration {
            self.text = "\(endValue)"
            displayLink?.invalidate()
            displayLink = nil
        }else {
            let percentage = elapsedTime / animateDuration
            let value = startValue + percentage * (endValue - startValue)
            self.text = "\(value)"
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
