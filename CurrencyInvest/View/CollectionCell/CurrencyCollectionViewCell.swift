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
    var smallBackView = UIView()
    var smallBackViewTapHandler : ((Bool)->())!
    var rateAmountTapHandler : ((Bool)->())!
    
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
        self.contentView.addSubview(smallBackView)
//        contentView.sendSubviewToBack(smallBackView)
        
        rateImage.translatesAutoresizingMaskIntoConstraints = false
        rateImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 19).isActive = true
        rateImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        rateImage.widthAnchor.constraint(equalToConstant: 44).isActive = true
        rateImage.heightAnchor.constraint(equalToConstant: 44).isActive = true
        rateImage.backgroundColor = UIColor.clear
        
        rateName.translatesAutoresizingMaskIntoConstraints = false
        rateName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        rateName.leadingAnchor.constraint(equalTo: self.rateImage.trailingAnchor, constant: 0).isActive = true
        rateName.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        rateName.widthAnchor.constraint(equalToConstant: 108).isActive = true
        rateName.textColor = UIColor.ciMaize
        rateName.font = UIFont.boldSystemFont(ofSize: 24)
        rateName.padding = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        rateName.textAlignment = .center

        
        rateAmount.translatesAutoresizingMaskIntoConstraints = false
        rateAmount.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        rateAmount.leadingAnchor.constraint(equalTo: self.rateName.trailingAnchor, constant: 10).isActive = true
        rateAmount.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 10).isActive = true
        rateAmount.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
        rateAmount.backgroundColor = UIColor.green
        rateAmount.text = "132456.456709"
        rateAmount.textAlignment = .right
        rateAmount.font = UIFont.boldSystemFont(ofSize: 24)
        rateAmount.textColor = UIColor.ciMaize
        rateAmount.isUserInteractionEnabled = true
        let rateAmountTapGesture = UITapGestureRecognizer(target: self, action: #selector(rateAmountTapped))
        rateAmount.addGestureRecognizer(rateAmountTapGesture)
        
        smallBackView.translatesAutoresizingMaskIntoConstraints = false
        smallBackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        smallBackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: -10).isActive = true
        smallBackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        smallBackView.widthAnchor.constraint(equalToConstant: 152).isActive = true
        smallBackView.backgroundColor = UIColor.clear
//        smallBackView.layer.borderWidth = 2
//        smallBackView.layer.borderColor = UIColor.darkGray.cgColor
//        smallBackView.layer.cornerRadius = 10
        smallBackView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(smallBackViewTapped))
        smallBackView.addGestureRecognizer(tapGesture)
    }
    
    @objc func smallBackViewTapped() {
        smallBackViewTapHandler(true)
    }
    
    @objc func rateAmountTapped() {
        rateAmountTapHandler(true)
    }
    
}
