//
//  NumberPadBtnCollectionViewCell.swift
//  re
//
//  Created by Laurence  Chen on 2018/9/17.
//  Copyright © 2018 Re Corporation Limited. All rights reserved.
//

import UIKit

class NumberPadBtnCollectionViewCell: UICollectionViewCell {
    
    var numLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        
        contentView.backgroundColor = UIColor.white
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.reNavigationBarRed.cgColor
        contentView.layer.cornerRadius = 6
        
        numLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        numLabel.backgroundColor = UIColor.clear
        numLabel.textAlignment = .center
        numLabel.textColor = UIColor.reNavigationBarRed
        numLabel.font = UIFont.boldSystemFont(ofSize: 34)
        numLabel.center = contentView.center
        
        self.contentView.addSubview(numLabel)
    }
    
}
