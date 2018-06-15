//
//  Managed.swift
//  Trakkers
//
//  Created by Svitlana Moiseyenko on 9/16/17.
//  Copyright © 2017 Nicholas. All rights reserved.
//

import Foundation
import CoreData

protocol Managed: class, NSFetchRequestResult {
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
}


extension Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
    
    static var sortedFetchRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
    
    static var fetchRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entityName)
        return request
    }
}


extension Managed where Self: NSManagedObject {
    static var entityName: String { return entity().name!  }
    
    static func fetch(in context: NSManagedObjectContext, configurationBlock: (NSFetchRequest<Self>) -> () = { _ in }) -> [Self] {
        let request = NSFetchRequest<Self>(entityName: Self.entityName)
        configurationBlock(request)
        return try! context.fetch(request)
    }
    
    static func findOrFetch(in context: NSManagedObjectContext, matching predicate: NSPredicate) -> Self? {
        guard let object = materializedObject(in: context, matching: predicate) else {
            return fetch(in: context) { request in
                request.predicate = predicate
                request.returnsObjectsAsFaults = false
                request.fetchBatchSize = 1
                request.fetchLimit = 1
                }.first
        }
        return object
    }
    
    static func materializedObject(in context: NSManagedObjectContext, matching predicate: NSPredicate) -> Self? {
        for object in context.registeredObjects where !object.isFault {
            guard let result = object as? Self, predicate.evaluate(with: result) else { continue }
            return result
        }
        return nil
    }
    
    static func objectByID(context: NSManagedObjectContext, id: Int) -> Self? {
        return self.findOrFetch(in: context, matching: NSPredicate(format: "id == %d", id))
    }
    
    static func objectByRelatedID(context: NSManagedObjectContext, relationId: Int, relationName: String) -> Self? {
        return self.findOrFetch(in: context, matching: NSPredicate(format: relationName + ".id == %d", relationId))
    }
    
    static func objectByIdAndRelatedID(context: NSManagedObjectContext, id: Int, relationId: Int, relationName: String) -> Self? {
        return self.findOrFetch(in: context, matching: NSPredicate(format: "id == %d AND \(relationName).id == %d", id, relationId))
    }
    
    // TODO: CR array should be
    static func objectByRelatedIDs(context: NSManagedObjectContext, locationId: Int, deviceTypeId: Int) -> Self? {
        return self.findOrFetch(in: context, matching: NSCompoundPredicate(andPredicateWithSubpredicates:[
            NSPredicate(format: "deviceType.id == %d", deviceTypeId),
            NSPredicate(format: "location.id == %d", locationId)]
        ))
    }
}

