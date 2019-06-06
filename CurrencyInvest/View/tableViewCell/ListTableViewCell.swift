//
//  ListTableViewCell.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/4/30.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(with exchange:[Exchange],indexPath:IndexPath) {
        
        commentLabel.text = exchange[indexPath.row].comment
        commentLabel.textColor = UIColor.ciDownArrowBlue
        
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.borderColor = UIColor.ciButtonGreen.cgColor
        nameLabel.layer.cornerRadius = 5
        nameLabel.backgroundColor = UIColor.ciDarkGunMetal
        nameLabel.text = exchange[indexPath.row].name
        nameLabel.textColor = UIColor.ciButtonGreen
        
        amountLabel.textColor = UIColor.ciMaize
        amountLabel.text = "\(exchange[indexPath.row].amount)"
        
        
    }
    
    
}
