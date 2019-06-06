//
//  RateTypePickerTableViewCell.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/4/8.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit

class RateTypePickerAlphabetTableViewCell: UITableViewCell {
    
    var backView = UIView()
    var label = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setView() {
        
        
        self.contentView.addSubview(backView)
        self.contentView.addSubview(label)
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 3).isActive = true
        backView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 3).isActive = true
        backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -3).isActive = true
        backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -3).isActive = true
        backView.backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 10
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.ciMaize
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
    }
    
    func haveSelected (indexInt:Int, selected:Bool) {
        
        if indexInt == 999 {
            return
        }
        
        backView.backgroundColor = selected ? UIColor.white.withAlphaComponent(0.5) : UIColor.clear

    }
    
    func resetBackGroundColor () {
        
        backView.backgroundColor = UIColor.clear

    }
    
    
    func setData(dataArray:[String], indexPath:IndexPath) {
        
        label.text = dataArray[indexPath.row]
        
    }
    
    
}
