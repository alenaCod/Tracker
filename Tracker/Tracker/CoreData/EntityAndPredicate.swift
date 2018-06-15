//
//  EntityAndPredicate.swift
//  Trakkers
//
//  Created by Svitlana Moiseyenko on 9/17/17.
//  Copyright © 2017 Nicholas. All rights reserved.
//

import Foundation
import CoreData

final class EntityAndPredicate<A : NSManagedObject> {
    let entity: NSEntityDescription
    let predicate: NSPredicate
    
    init(entity: NSEntityDescription, predicate: NSPredicate) {
        self.entity = entity
        self.predicate = predicate
    }
}

extension EntityAndPredicate {
    var fetchRequest: NSFetchRequest<A> {
        let request = NSFetchRequest<A>()
        request.entity = entity
        request.predicate = predicate
        return request
    }
}

