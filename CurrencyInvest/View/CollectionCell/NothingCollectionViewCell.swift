//
//  NothingCollectionViewCell.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/4/18.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit

class NothingCollectionViewCell: UICollectionViewCell {
    
    var plusBtn = UIButton()
    var bottomLine = UIView()
    var plusBtnTapHandler : ((Bool)->())!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        
        self.contentView.backgroundColor = UIColor.clear
        
        self.contentView.addSubview(plusBtn)
        self.contentView.addSubview(bottomLine)
        
        
        
        plusBtn.translatesAutoresizingMaskIntoConstraints = false
        plusBtn.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        plusBtn.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        plusBtn.widthAnchor.constraint(equalToConstant: 140).isActive = true
        plusBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        plusBtn.backgroundColor = UIColor.ciButtonGreen
        plusBtn.setTitle("+", for: .normal)
        plusBtn.titleLabel?.textColor = UIColor.darkGray
        plusBtn.addTarget(self, action: #selector(plusBtnTapped), for: .touchUpInside)
        plusBtn.layer.cornerRadius = 20
        plusBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 26)
        
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 2).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        bottomLine.backgroundColor = UIColor.ciButtonGreen.withAlphaComponent(0.8)
    }
    
    @objc func plusBtnTapped() {
        plusBtnTapHandler(true)
    }
}
