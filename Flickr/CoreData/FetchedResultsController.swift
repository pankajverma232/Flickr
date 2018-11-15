//
//  FetchedResultsController.swift
//  Flickr
//
//  Created by Pankaj Verma on 10/11/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import Foundation
import CoreData
import UIKit

enum FetchedResultsControllerAction {
    case willChangeContent
    case SectionAction(Int, NSFetchedResultsChangeType)
    case ObjectAtion(IndexPath?, IndexPath?, NSFetchedResultsChangeType)
    case didChangeContent
}

class FetchedResultsController:NSObject, NSFetchedResultsControllerDelegate{
    var fetchedResultsController: NSFetchedResultsController<NSManagedObject>!
    var sections: [NSFetchedResultsSectionInfo]? {
        return fetchedResultsController.sections
    }
    func objectAtIndexPath(indexPath:IndexPath) -> FlickrPhotos {
        return fetchedResultsController.object(at: indexPath) as! FlickrPhotos
    }
    let action:(FetchedResultsControllerAction)->()
//    let collectionView:UICollectionView
    init(action: @escaping(FetchedResultsControllerAction)->()) {
        self.action = action
        super.init()
        self.initializeFetchedResultsController()
    }
    func initializeFetchedResultsController() {
        let request =
            NSFetchRequest<NSManagedObject>(entityName: K.entitiName)

        let dataSort = NSSortDescriptor(key: "url", ascending: false)
        request.sortDescriptors = [dataSort]
        request.fetchLimit = 15
        let moc = CoreDataManager.shared.managedObjectContext
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        fetchedResultsController.fetchRequest.fetchLimit = 25

        do {
            try fetchedResultsController.performFetch() //now fetchedResultsController has data. It knows about  sections, rows and items initial data to show in view
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }

    //MARK:- NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        action(.willChangeContent)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) { // section update
        action(.SectionAction(sectionIndex, type))
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        action(.ObjectAtion(indexPath, newIndexPath, type))
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        action(.willChangeContent)
    }
}
