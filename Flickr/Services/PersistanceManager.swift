//
//  PersistanceManager.swift
//  Flickr
//
//  Created by Pankaj Verma on 06/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class PersistanceManager:Persistable {

    func saveUrls(_ urls:[String]) -> Void{

        let entity =
            NSEntityDescription.entity(forEntityName: K.entitiName,
                                       in: CoreDataManager.shared.managedObjectContext)!
        
        for url in urls {
        let poster = NSManagedObject(entity: entity, insertInto: CoreDataManager.shared.managedObjectContext)
        poster.setValue(url, forKeyPath: PersistenceKey.url)
        }
        //save
        CoreDataManager.shared.saveChanges()
    }
    
    

    func removeUrs() {
 
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.entitiName)
        
        let result = try? CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
        let resultData = result as! [FlickrPhotos]
        
        for object in resultData {
            CoreDataManager.shared.managedObjectContext.delete(object)
        }
        
        do {
            try CoreDataManager.shared.managedObjectContext.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
}
