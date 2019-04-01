//
//  CurrencyTwo.swift
//  CurrencyInvest
//
//  Created by Laurence Chen on 2019/3/31.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import UIKit


class CurrencyTwo: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    
    var collectionView = UICollectionView()
    
    
    override func viewDidLoad() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 40, left: 0, bottom: 10, right: 0)
        flowLayout.itemSize = CGSize(width: self.view.frame.width * 0.8 , height: 140)
        flowLayout.minimumLineSpacing = CGFloat(integerLiteral: 30)
        flowLayout.minimumInteritemSpacing = CGFloat(integerLiteral: 10)
        //            flowLayout.headerReferenceSize = CGSize(width: self.view.width, height: 50)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical //預設
        collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.register(bitCoinCollectionViewCell.self, forCellWithReuseIdentifier: "reuseCell")
        collectionView.backgroundColor = UIColor.ciDarkGunMetal
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 154).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
        collectionView.setContentOffset(CGPoint(x: 0, y: -300), animated: false)
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
   
    
    
    
}
