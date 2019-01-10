//
//  GradientView.swift
//  re
//
//  Created by BillHsiao on 2017/12/12.
//  Copyright © 2017年 Re Corporation Limited. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var firstColor: UIColor = .black
    @IBInspectable var secondColor: UIColor = .white

    var gradientLayer: CAGradientLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        createGradientLayer()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        createGradientLayer()
    }
}

extension GradientView {
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        layer.mask = gradientLayer
    }
}
