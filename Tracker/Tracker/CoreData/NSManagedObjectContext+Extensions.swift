//
//  NSManagedObjectContext+Extensions.swift
//  Tracker
//
//  Created by Sveta on 6/17/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    @discardableResult
    func insertObject<A: NSManagedObject>() -> A where A: Managed {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else { fatalError("Wrong object type") }
        return obj
    }
    
    func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }

    }
    
    func performChanges(block: @escaping () -> ()) {
        if self.hasChanges {
            perform {
                block()
                _ = self.saveOrRollback()
            }
        }
    }
}
