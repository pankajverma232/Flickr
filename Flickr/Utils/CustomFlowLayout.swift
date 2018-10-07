//
//  CustomFlowLayout.swift
//  Flickr
//
//  Created by Pankaj Verma on 06/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    let numberOfColumns: CGFloat = 3
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
    override var itemSize: CGSize {
        set {
            
        }
        get {
            let itemWidth = (self.collectionView!.frame.width - (numberOfColumns-1))/numberOfColumns
            return CGSize.init(width: itemWidth, height: itemWidth*1.2)
        }
    }
}
