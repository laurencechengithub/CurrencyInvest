//
//  bitCoinCollectionViewCell.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/3/4.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit

class bitCoinCollectionViewCell: UICollectionViewCell {
    
    var bitCoinCellLabelPrice:CountingLabel!
    var bitCoinCellLabelType = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        
        self.backgroundColor = UIColor.ciDeepKoamaru
        self.contentView.addSubview(bitCoinCellLabelType)
        
        bitCoinCellLabelType.translatesAutoresizingMaskIntoConstraints = false
        bitCoinCellLabelType.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        bitCoinCellLabelType.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        bitCoinCellLabelType.heightAnchor.constraint(equalToConstant: 44).isActive = true
        bitCoinCellLabelType.widthAnchor.constraint(equalToConstant: 64).isActive = true
        bitCoinCellLabelType.backgroundColor = UIColor.clear
        bitCoinCellLabelType.textAlignment = .center
        bitCoinCellLabelType.font = UIFont.boldSystemFont(ofSize: 30)
        bitCoinCellLabelType.textColor = UIColor.white
        
    }
    
    
    func setCellLabelWith(typeArray:[String], priceArray:[Double], indexPath:IndexPath) {
        
        
        bitCoinCellLabelType.text = typeArray[indexPath.row]
        bitCoinCellLabelPrice = CountingLabel(startValue: 0, endValue: priceArray[indexPath.row], duration: 1)
        self.contentView.addSubview(bitCoinCellLabelPrice)
        
        bitCoinCellLabelPrice.translatesAutoresizingMaskIntoConstraints = false
        bitCoinCellLabelPrice.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        bitCoinCellLabelPrice.leadingAnchor.constraint(equalTo: bitCoinCellLabelType.trailingAnchor, constant: 15).isActive = true
        bitCoinCellLabelPrice.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        bitCoinCellLabelPrice.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10 ).isActive = true
    
        
        
    }
    

    
}



