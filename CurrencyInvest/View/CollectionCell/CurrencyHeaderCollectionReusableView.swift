//
//  CurrencyHeaderCollectionReusableView.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/4/2.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit

class CurrencyHeaderCollectionReusableView: UICollectionReusableView {
    
    var saveBtn = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        
        self.backgroundColor = UIColor.clear
        self.addSubview(saveBtn)
        
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        saveBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        saveBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        saveBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        saveBtn.backgroundColor = UIColor.ciButtonGreen
        saveBtn.setTitle("Save current exchange", for: .normal)
        saveBtn.setTitleColor(UIColor.white, for: .normal)
        saveBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        saveBtn.layer.cornerRadius = 20
        
    }
    
}
