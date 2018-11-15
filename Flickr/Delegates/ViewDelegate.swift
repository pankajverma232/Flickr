//
//  ViewDelegate.swift
//  Flickr
//
//  Created by Pankaj Verma on 10/11/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import Foundation
import UIKit
enum CollectionViewAction {
    case select
    case display
}
class ViewDelegate: NSObject, UICollectionViewDelegate {
    var completion:(IndexPath, CollectionViewAction)->()
    init(completion:@escaping(IndexPath, CollectionViewAction)->()) {
        self.completion = completion
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        completion(indexPath, .select)
    }
    
        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
 
            completion(indexPath, .display)
        }
    
}
