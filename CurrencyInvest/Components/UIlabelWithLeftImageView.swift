//
//  UIlabelWithLeftImageView.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/4/11.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import UIKit

class UIlabelWithLeftImageView: UIViewController {
    
    var backgroundView = UIView()
    var rateImage = UIImageView()
    var rateName = UILabel()
    
    override func viewDidLoad() {
        setView ()
    }
    
    func setView () {
        
        self.view.addSubview(backgroundView)
        self.backgroundView.addSubview(rateImage)
        self.backgroundView.addSubview(rateName)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        
        rateImage.translatesAutoresizingMaskIntoConstraints = false
        rateImage.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 19).isActive = true
        rateImage.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 0).isActive = true
        rateImage.widthAnchor.constraint(equalToConstant: 44).isActive = true
        rateImage.heightAnchor.constraint(equalToConstant: 44).isActive = true
        rateImage.backgroundColor = UIColor.clear
        
        rateName.translatesAutoresizingMaskIntoConstraints = false
        rateName.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 20).isActive = true
        rateName.leadingAnchor.constraint(equalTo: self.rateImage.trailingAnchor, constant: 5).isActive = true
        rateName.bottomAnchor.constraint(equalTo: self.backgroundView.bottomAnchor, constant: -10).isActive = true
        rateName.widthAnchor.constraint(equalToConstant: 108).isActive = true
        //        rateName.backgroundColor = UIColor.green
        rateName.textColor = UIColor.ciMaize
        rateName.font = UIFont.boldSystemFont(ofSize: 24)
        rateName.padding = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        rateName.textAlignment = .center
        rateName.layer.borderWidth = 1
        rateName.layer.borderColor = UIColor.darkGray.cgColor
        rateName.layer.cornerRadius = 20
        
        
        
        
    }
    
    
    
    
    
}

