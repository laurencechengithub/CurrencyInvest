//
//  UIViewcontrollerExtension.swift
//  re
//
//  Created by Hsiao Wind on 2017/4/26.
//  Copyright © 2017年 Re Corporation Limited. All rights reserved.
//

import UIKit

// Add Blur Effect
extension UIViewController {
    func addBlurEffectAndView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView()
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView, at: 0)
        
        UIView.animate(withDuration: 0.3, animations: {
            blurEffectView.effect = blurEffect
        })
    }
}

// Set BackBarButtonItem title empty
extension UIViewController {
    func setBarBackTitleEmpty() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
