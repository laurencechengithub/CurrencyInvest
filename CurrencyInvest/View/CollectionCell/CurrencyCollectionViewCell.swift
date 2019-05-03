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
    var saveToListBtnHandler : ((Bool)->())!
    var bottomLine = UIView()
    var streightLine = UIView()
    var saveToListBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setView() {
        
        contentView.backgroundColor = UIColor.ciDarkGunMetal
        
        self.contentView.addSubview(rateImage)
        self.contentView.addSubview(rateName)
        self.contentView.addSubview(rateAmount)
        self.contentView.addSubview(smallBackView)
//        self.contentView.addSubview(bottomLine)
        self.contentView.addSubview(streightLine)
        self.contentView.addSubview(saveToListBtn)
        

        rateImage.translatesAutoresizingMaskIntoConstraints = false
        rateImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 19).isActive = true
        rateImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        rateImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        rateImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        rateImage.backgroundColor = UIColor.clear
        
        rateName.translatesAutoresizingMaskIntoConstraints = false
        rateName.topAnchor.constraint(equalTo: rateImage.topAnchor, constant: -4).isActive = true
        rateName.leadingAnchor.constraint(equalTo: self.rateImage.trailingAnchor, constant: 10).isActive = true
        rateName.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        rateName.widthAnchor.constraint(equalToConstant: 58).isActive = true
        rateName.textColor = UIColor.white
        rateName.font = UIFont.boldSystemFont(ofSize: 22)
        rateName.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        rateName.textAlignment = .left
//        rateName.backgroundColor = UIColor.

        
        rateAmount.translatesAutoresizingMaskIntoConstraints = false
        rateAmount.topAnchor.constraint(equalTo: self.rateName.topAnchor, constant: 0).isActive = true
        rateAmount.leadingAnchor.constraint(equalTo: self.streightLine.trailingAnchor, constant: 6).isActive = true
        rateAmount.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        rateAmount.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -25).isActive = true
        rateAmount.backgroundColor = UIColor.clear
        rateAmount.textAlignment = .left
        rateAmount.font = UIFont.boldSystemFont(ofSize: 22)
        rateAmount.textColor = UIColor.white
        rateAmount.isUserInteractionEnabled = true
        let rateAmountTapGesture = UITapGestureRecognizer(target: self, action: #selector(rateAmountTapped))
        rateAmount.addGestureRecognizer(rateAmountTapGesture)
        
        smallBackView.translatesAutoresizingMaskIntoConstraints = false
        smallBackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        smallBackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: -10).isActive = true
        smallBackView.heightAnchor.constraint(equalToConstant: self.contentView.frame.height).isActive = true
        smallBackView.trailingAnchor.constraint(equalTo: self.rateName.trailingAnchor, constant: 0).isActive = true
//        smallBackView.widthAnchor.constraint(equalToConstant: 98).isActive = true
        smallBackView.backgroundColor = UIColor.green.withAlphaComponent(0.7)
//        smallBackView.layer.borderWidth = 2
//        smallBackView.layer.borderColor = UIColor.darkGray.cgColor
//        smallBackView.layer.cornerRadius = 10
        smallBackView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(smallBackViewTapped))
        smallBackView.addGestureRecognizer(tapGesture)
    

//        bottomLine.translatesAutoresizingMaskIntoConstraints = false
//        bottomLine.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
//        bottomLine.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 2).isActive = true
//        bottomLine.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
//        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
//        bottomLine.backgroundColor = UIColor.ciButtonGreen
        
        streightLine.translatesAutoresizingMaskIntoConstraints = false
        streightLine.leadingAnchor.constraint(equalTo: self.rateName.trailingAnchor, constant: 2).isActive = true
        streightLine.topAnchor.constraint(equalTo: self.rateName.topAnchor, constant: 3).isActive = true
        streightLine.widthAnchor.constraint(equalToConstant: 2).isActive = true
        streightLine.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        streightLine.backgroundColor = UIColor.ciButtonGreen
        
        saveToListBtn.translatesAutoresizingMaskIntoConstraints = false
        saveToListBtn.topAnchor.constraint(equalTo: rateAmount.topAnchor, constant: 10).isActive = true
        saveToListBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        saveToListBtn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        saveToListBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        saveToListBtn.setImage(UIImage(named: "download"), for: .normal)
        saveToListBtn.addTarget(self, action: #selector(saveNewDataToCoreData), for: .touchUpInside)
        
    }
    
    @objc func smallBackViewTapped() {
        print("smallBackViewTapped")
        smallBackViewTapHandler(true)
    }
    
    @objc func rateAmountTapped() {
        rateAmountTapHandler(true)
    }
    
    @objc func saveNewDataToCoreData() {
        saveToListBtnHandler(true)
        
    }
    
    
}
