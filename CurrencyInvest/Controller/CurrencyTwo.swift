//
//  CurrencyTwo.swift
//  CurrencyInvest
//
//  Created by Laurence Chen on 2019/3/31.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import UIKit


class CurrencyTwo: UIViewController {

    var collectionView: UICollectionView!
    let flowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.ciDarkGunMetal
        
        flowLayout.sectionInset = UIEdgeInsets(top: 40, left: 0, bottom: 10, right: 0)
        flowLayout.itemSize = CGSize(width: self.view.frame.width * 0.8 , height: 64)
        flowLayout.minimumLineSpacing = CGFloat(integerLiteral: 30)
        flowLayout.minimumInteritemSpacing = CGFloat(integerLiteral: 10)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical //預設
        flowLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 54)
        collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.register(CurrencyCollectionViewCell.self, forCellWithReuseIdentifier: "reuseCell")
        collectionView.backgroundColor = UIColor.ciDarkGunMetal
        
        collectionView.register(CurrencyHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 154).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)//collectionView 底下滑到空間
        collectionView.setContentOffset(CGPoint(x: 0, y: -150), animated: false)// 手機上顯示collectionView顯示的部分
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    

   
    
    
    
}


extension CurrencyTwo: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseCell", for: indexPath) as! CurrencyCollectionViewCell
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! CurrencyHeaderCollectionReusableView
    
        return view
    }
    
    
    
    
}



extension CurrencyTwo:  UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}


extension CurrencyTwo: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        print(contentOffsetY)
        if contentOffsetY >= -10 {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            flowLayout.sectionHeadersPinToVisibleBounds = true
        } else if contentOffsetY <= -10 {
            collectionView.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
            flowLayout.sectionHeadersPinToVisibleBounds = false
        }
        
    }
    
    
}
