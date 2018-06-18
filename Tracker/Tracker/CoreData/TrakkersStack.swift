//
//  TrakkersStack.swift
//  Tracker
//
//  Created by Sveta on 6/17/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import Foundation
import CoreData

func createTrakkersContainer(completion: @escaping (NSPersistentContainer) -> ()) {
    let container = NSPersistentContainer(name: "Tracker")
    container.loadPersistentStores { _, error in
        guard error == nil else { fatalError("Failed to load store: \(error)") }
        DispatchQueue.main.async { completion(container) }
    }
}
