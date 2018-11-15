//
//  CoreDataManager.swift
//  Flickr
//
//  Created by Pankaj Verma on 14/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class CoreDataManager{
    
    static let shared = CoreDataManager(modelName: "Flickr")
    
    var modelName:String
    let persistentStoreCoordinator:NSPersistentStoreCoordinator
    
    private init(modelName: String) {
        self.modelName = modelName
        persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
    }
    
    lazy var privateManagedObjectContext: NSManagedObjectContext = {
        // Initialize Managed Object Context
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        // Configure Managed Object Context
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return managedObjectContext
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        managedObjectContext.parent = self.privateManagedObjectContext
        
        return managedObjectContext
    }()
    
    @objc func saveChanges() {
        managedObjectContext.perform {
            do {
                if self.managedObjectContext.hasChanges {
                    try self.managedObjectContext.save()
                }
            } catch {
                let saveError = error as NSError
                print("Unable to Save Changes of Managed Object Context")
                print("\(saveError), \(saveError.localizedDescription)")
            }
            
            self.privateManagedObjectContext.perform {
                do {
                    if self.privateManagedObjectContext.hasChanges {
                        try self.privateManagedObjectContext.save()
                    }
                } catch {
                    let saveError = error as NSError
                    print("Unable to Save Changes of Private Managed Object Context")
                    print("\(saveError), \(saveError.localizedDescription)")
                }
            }
            
        }
    }
}
