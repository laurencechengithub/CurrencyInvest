//
//  CurrencyHeaderCollectionReusableView.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/4/2.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit

class CurrencyHeaderCollectionReusableView: UICollectionReusableView {
    
    var deleteBtn = UIButton()
    var btnTappedHandler:((Bool)->())!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        
        self.backgroundColor = UIColor.ciDarkGunMetal
        self.addSubview(deleteBtn)
        
        deleteBtn.translatesAutoresizingMaskIntoConstraints = false
        deleteBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        deleteBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 139).isActive = true
        deleteBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -139).isActive = true
        deleteBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        deleteBtn.backgroundColor = UIColor.ciButtonGreen
        deleteBtn.setTitle("−", for: .normal)
        deleteBtn.setTitleColor(UIColor.white, for: .normal)
        deleteBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 26)
        deleteBtn.layer.cornerRadius = 20
        deleteBtn.addTarget(btnTapped, action: #selector(btnTapped), for: .touchUpInside)
    }
    
    @objc func btnTapped() {
        btnTappedHandler(true)
    }
    
}
