//
//  TrakkersStack.swift
//  Trakkers
//
//  Created by Svitlana Moiseyenko on 9/17/17.
//  Copyright © 2017 Nicholas. All rights reserved.
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
