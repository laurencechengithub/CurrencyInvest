//
//  CurrencyCollectionViewCell.swift
//  CurrencyInvest
//
//  Created by Laurence Chen on 2019/3/31.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell {
    
    var rateImage = UIImageView()
    var rateName = UILabel()
    var rateAmount = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setView() {
        
        contentView.backgroundColor = UIColor.clear
        
        self.contentView.addSubview(rateImage)
        self.contentView.addSubview(rateName)
        self.contentView.addSubview(rateAmount)
        
        rateImage.translatesAutoresizingMaskIntoConstraints = false
        rateImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 19).isActive = true
        rateImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        rateImage.widthAnchor.constraint(equalToConstant: 44).isActive = true
        rateImage.heightAnchor.constraint(equalToConstant: 44).isActive = true
        rateImage.backgroundColor = UIColor.blue
        
        rateName.translatesAutoresizingMaskIntoConstraints = false
        rateName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        rateName.leadingAnchor.constraint(equalTo: self.rateImage.trailingAnchor, constant: 0).isActive = true
        rateName.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 10).isActive = true
        rateName.widthAnchor.constraint(equalToConstant: 68).isActive = true
//        rateName.backgroundColor = UIColor.green
        rateName.text = "USD"
        rateName.textColor = UIColor.ciMaize
        rateName.font = UIFont.boldSystemFont(ofSize: 20)
        rateName.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        rateName.textAlignment = .left
        
        rateAmount.translatesAutoresizingMaskIntoConstraints = false
        rateAmount.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        rateAmount.leadingAnchor.constraint(equalTo: self.rateName.trailingAnchor, constant: 10).isActive = true
        rateAmount.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 10).isActive = true
        rateAmount.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
        rateAmount.backgroundColor = UIColor.clear
        rateAmount.text = "132456.4567"
        rateAmount.textAlignment = .right
        rateAmount.font = UIFont.boldSystemFont(ofSize: 24)
        rateAmount.textColor = UIColor.ciMaize
        
        
        
    }
    
    
}
