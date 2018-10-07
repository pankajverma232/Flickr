//
//  ImageSaver.swift
//  Flickr
//
//  Created by Pankaj Verma on 06/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class ImageCache {
    
    func getImageForKey(_ url:String?) -> Data? {
        if url == nil {
            return nil
        }
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return nil
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: K.entitiName)
        fetchRequest.predicate = NSPredicate(format: "url == %@", url!)
        
        do {
            let poster:[NSManagedObject] = try managedContext.fetch(fetchRequest)
            if poster.count > 0{
                return poster[0].value(forKeyPath: PersistenceKey.data) as? Data
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func addImage(data:Data, forKey url:String) -> Void{
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let entity =
            NSEntityDescription.entity(forEntityName: K.entitiName,
                                       in: managedContext)!
        
        let poster = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        poster.setValue(data, forKeyPath: PersistenceKey.data)
        poster.setValue(url, forKeyPath: PersistenceKey.url)
        
        //save
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save image. \(error), \(error.userInfo)")
        }
    }

    func deleteAllRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: K.entitiName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
}
