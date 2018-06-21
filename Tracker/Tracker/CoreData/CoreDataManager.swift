//
//  CoreDataManager.swift
//  Tracker
//
//  Created by Sveta on 6/17/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Tracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
    
    static let sharedInstance = CoreDataManager()
    fileprivate var mainContext: NSManagedObjectContext!
    fileprivate var privateContext: NSManagedObjectContext!
    
    private init() {
        self.mainContext = persistentContainer.viewContext
        self.privateContext = persistentContainer.newBackgroundContext()
    }
    func getPrivateContext() -> NSManagedObjectContext {
        return self.privateContext
    }
    
    func createCuncurrentContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
  
    func saveActivity(data: CurrentActivity?, completion: @escaping ()->()) {
        guard let item = data else {
            completion()
            return
        }
        privateContext.perform {
            DBActivity.insert(into: self.privateContext, item: item)

            self.privateContext.performChanges(block: {
               print("saved successfully")
                completion()
            })
        }
    }
    
    func getActivities(completion: @escaping (_ activities: [DBActivity])->()) {
        privateContext.perform {
            let request = DBActivity.sortedFetchRequest
            request.returnsObjectsAsFaults = false
            let activities: [DBActivity] = try! self.privateContext.fetch(request)
            print("Get activities: ", activities)
            completion(activities)
        }
    }
  
    func getTotalDistance(completion: @escaping (_ totalDistance: Double)->()) {
      privateContext.perform {
        let request = DBActivity.sortedFetchRequest
        request.returnsObjectsAsFaults = false
        let activities: [DBActivity] = try! self.privateContext.fetch(request)
        let totalDistance = activities.map({$0.distance}).reduce(0, +)
        print("Get distance: ", totalDistance)
        completion(totalDistance)
      }
    }
}
