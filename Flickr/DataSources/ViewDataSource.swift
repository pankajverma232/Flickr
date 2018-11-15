//
//  ViewDataSource.swift
//  Flickr
//
//  Created by Pankaj Verma on 09/11/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class ViewDataSource: NSObject, UICollectionViewDataSource {
    let  cellIdentifier = "ImageCell";
    var fetchedResultsController: FetchedResultsController!

    init(fetchedResultsController:FetchedResultsController) {
        self.fetchedResultsController = fetchedResultsController
    }

    
    //MARK:- UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return photos.count
        guard let sections = fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ImageCell
        
        if self.validateIndexPath(indexPath) {
            let obj = self.fetchedResultsController.objectAtIndexPath(indexPath: indexPath)
            if let url = obj.url{
                cell.setImageForUrl(url: url)
            }
        } else {
            print("Attempting to configure a cell for an indexPath that is out of bounds: \(indexPath)")
        }
        return cell
    }
    func validateIndexPath(_ indexPath: IndexPath) -> Bool {
        if let sections = self.fetchedResultsController?.sections,
            indexPath.section < sections.count {
            if indexPath.row < sections[indexPath.section].numberOfObjects {
                return true
            }
        }
        return false
    }
 
}
