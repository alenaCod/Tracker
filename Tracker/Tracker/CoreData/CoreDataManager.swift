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
            //container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        })
        return container
    }()
    
    static let sharedInstance = CoreDataManager()
    fileprivate var mainContext: NSManagedObjectContext!
    fileprivate var privateContext: NSManagedObjectContext!
    
    private init() {
        self.mainContext = persistentContainer.viewContext
        self.privateContext = persistentContainer.newBackgroundContext()
        //privateContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        // Add Observer
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(forName: .NSManagedObjectContextObjectsDidChange, object: nil, queue: nil) { note in
//            self.privateContext.perform({
//                self.privateContext.mergeChanges(fromContextDidSave: note) //TODO: think to remove
//            })
//        }
    }
    func getPrivateContext() -> NSManagedObjectContext {
        return self.privateContext
    }
    
    func createCuncurrentContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    //DeviceTypes
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
    
    // DeviceModels
//    func saveDeviceModels(data: [JSONDeviceModels]?, completion: @escaping ()->()) {
//        guard let items = data else {
//            completion()
//            return
//        }
//        privateContext.perform {
//            for item in items {
//               DeviceModel.insert(into: self.privateContext, item: item)
//            }
//            self.privateContext.performChanges(block: {
//                //self.getDeviceModels(completion: {_ in })
//                completion()
//            })
//        }
//    }
//    
//    func getDeviceModels(completion: @escaping (_ deviceModels: [DeviceModel])->()) {
//        privateContext.perform {
//            let request = DeviceModel.sortedFetchRequest
//            request.returnsObjectsAsFaults = false
//            let deviceModels: [DeviceModel] = try! self.privateContext.fetch(request)
//            print("Get device models: ", deviceModels)
//            completion(deviceModels)
//        }
//    }
//    
//   // Devices
//    func saveDevices(data: [JSONDevice]?, completion: @escaping ()->()) {
//        guard let items = data else {
//            completion()
//            return
//        }
//        privateContext.perform {
//            guard items.count >  0 else {
//                NSNotification.Name.SaveDevicesNotification.post()
//                completion()
//                return
//            }
//            for item in items {
//                Device.insert(into: self.privateContext, item: item)
//            }
//            self.privateContext.performChanges(block: {
//                //self.getDevices(completion: {_ in })
//                NSNotification.Name.SaveDevicesNotification.post()
//                completion()
//            })
//        }
//    }
//    
//    func getDevices(completion: @escaping (_ devices: [Device])->()) {
//        privateContext.perform {
//            let request = Device.sortedFetchRequest
//            request.returnsObjectsAsFaults = false
//            let devices: [Device] = try! self.privateContext.fetch(request)
//            //print("Get device: ", devices)
//            completion(devices)
//        }
//    }
//    
//    func getDevices(filter: String? = nil, completion: @escaping (_ devices: [Device])->()) {
//        privateContext.perform {
//            let request = Device.sortedFetchRequest
//            request.returnsObjectsAsFaults = false
//            if let _filter = filter {
//                let predicate = NSPredicate(format: "serialNumber CONTAINS[cd] %@", _filter)
//                request.predicate = predicate
//            }
//            let devices: [Device] = try! self.privateContext.fetch(request)
//            completion(devices)
//        }
//    }
//    
//    //Locations
//    func saveLocations(data: [JSONLocation]?, completion: @escaping ()->()) {
//        guard let items = data else {
//            completion()
//            return
//        }
//        privateContext.perform {
//            for item in items {
//                Location.insert(into: self.privateContext, item: item)
//            }
//            self.privateContext.performChanges(block: {
//                //self.getLocations(completion: {_ in })
//                completion()
//            })
//        }
//    }
//    
//    func getLocations(completion: @escaping (_ location: [Location])->()) {
//        privateContext.perform {
//            let request = Location.sortedFetchRequest
//            request.returnsObjectsAsFaults = false
//            let locations: [Location] = try! self.privateContext.fetch(request)
//            print("Get Locations: ", locations)
//            completion(locations)
//        }
//    }
//    
//    func deviceUpdateOrDelete(deviceId: Int, parent: String, time: String,  toId: Int, to: String, completion: @escaping (_ device: Device?)->()) {
//        privateContext.perform {
//            let request = Device.sortedFetchRequest
//            request.returnsObjectsAsFaults = false
//            
//            let predicate = NSPredicate(format: "id == %d",deviceId.toInt16())
//            request.predicate = predicate
//            if let device = try! self.privateContext.fetch(request).first {
//                if !ModelUtil.isInChildLocations(locationId: toId){
//                  self.privateContext.delete(device)
//                } else {
//                  device.update(parent: parent, time: time, toId: toId, to: to)
//                }
//                NSNotification.Name.SaveDevicesNotification.post()
//                completion(device)
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    
//    func getDeviceType(deviceTypeId: Int, completion: @escaping (_ deviceType: DeviceType?)->()) {
//        privateContext.perform {
//            let request = DeviceType.sortedFetchRequest
//            request.returnsObjectsAsFaults = false
//            
//            let predicate = NSPredicate(format: "id == %d", deviceTypeId.toInt16())
//            request.predicate = predicate
//            if let deviceType = try! self.privateContext.fetch(request).first {
//                completion(deviceType)
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    
//    func findParent(child: Location, completion: @escaping (_ location: Location)->()) {
//        privateContext.perform {
//            let request = Location.sortedFetchRequest
//            request.returnsObjectsAsFaults = false
//            
//            let predicate = NSPredicate(format: "lft < %d AND rgt > %d AND idTree == %d", child.lft, child.rgt, child.idTree)
//            request.predicate = predicate
//            let location: Location = (try! self.privateContext.fetch(request).max(by: { $0.lft < $1.lft}))!
//            completion(location)
//        }
//    }
//    
//    func findLocation(locationId: Int16, completion: @escaping (_ location: Location?)->()) {
//        privateContext.perform {
//            let request = Location.sortedFetchRequest
//            request.returnsObjectsAsFaults = false
//            
//            let predicate = NSPredicate(format: "id == %d", locationId)
//            request.predicate = predicate
//            let location: Location? = try! self.privateContext.fetch(request).first ?? nil
//            completion(location)
//        }
//    }
//    
//    func getChildLocations(currentLocationId: Int, completion: @escaping (_ locations: [Location])->()) {
//        privateContext.perform {
//            guard let currentLocation = Location.objectByID(context: self.privateContext, id: currentLocationId) else {
//                 completion([])
//                return
//            }
//            print("DB currentLocation: ", currentLocation)
//            let request = Location.sortedFetchRequest
//            request.returnsObjectsAsFaults = false
//            
//            let predicate = NSPredicate(format: "lft >= %d AND rgt <= %d AND idTree == %d", currentLocation.lft, currentLocation.rgt, currentLocation.idTree)
//            request.predicate = predicate
//            let locations: [Location] = try! self.privateContext.fetch(request)
//            completion(locations)
//        }
//    }
//    
//    fileprivate var token: NSObjectProtocol?
//    func removeObserverToken() {
//        if let _token = self.token {
//            NotificationCenter.default.removeObserver(_token)
//            self.token = nil
//        }
//    }
//    
//    func clearData(completion: @escaping (_ returned: Bool)->()) {
//        self.privateContext.perform {
//
//            self.token = self.privateContext.addObjectsDidChangeNotificationObserver { [weak self] note in
//                guard note.deletedObjects.count > 0 else {
//                    self?.removeObserverToken()
//                    completion(false)
//                    return
//                }
//                self?.privateContext.mergeChanges(fromContextDidSave: note.getNotification())
//                self?.privateContext.performChanges {
//                    print("KUKU")
//                    self?.removeObserverToken()
//                    completion(true)
//                }
//            }
//            self.clearAllEntitiesByName("Device", context: self.privateContext, completion: { result in
//                if !result {
//                    completion(false)
//                }
//            })
//            self.clearAllEntitiesByName("Location", context: self.privateContext, completion: { result in
//                if !result {
//                    completion(false)
//                }
//            })
//        }
//    }
//}
//
//
//extension CoreDataManager {
//
//    
// 
////    func clearData(completion: @escaping (_ returned: Bool)->()) {
////        privateContext.perform {
////            var callbacksLeft = 2
////            var callback = true
////
////            func checkCompleted(returned: Bool) {
////                callbacksLeft -= 1
////                if !returned {
////                    callback = false
////                }
////                if callbacksLeft == 0 {
////                    completion(callback)
////                }
////            }
////            self.clearAllEntitiesByName("Device", context: self.privateContext, completion: { result in
////                checkCompleted(returned: result)
////            })
////            self.clearAllEntitiesByName("Location", context: self.privateContext, completion: { result in
////                checkCompleted(returned: result)
////            })
////        }
////
////    }
////
//    func clearAllEntitiesByName(_ name: String, context: NSManagedObjectContext, completion: @escaping (_ returned: Bool)->()) {
//        persistentContainer.performBackgroundTask { privateManagedObjectContext in
//
//            let request = NSFetchRequest<NSFetchRequestResult>(entityName: name)
//            // All the entity_name with `name` equal to "Max"
//            //let predicate = NSPredicate(format: "name == %@", "Max")
//            // Assigns the predicate to the request
//            //request.predicate = predicate
//            
//            // Creates new batch delete request with a specific request
//            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
//            
//            // Asks to return the objectIDs deleted
//            deleteRequest.resultType = .resultTypeObjectIDs
//            
//            do {
//                // Executes batch
//                let result = try privateManagedObjectContext.execute(deleteRequest) as? NSBatchDeleteResult
//                
//                // Retrieves the IDs deleted
//                guard let objectIDs = result?.result as? [NSManagedObjectID] else { return }
//                
//                // Updates the private context
//                let changes = [NSDeletedObjectsKey: objectIDs]
//                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [self.privateContext])
//                completion(true)
//            } catch {
//                print("Failed to execute request: \(error)")
//                completion(false)
//            }
//        }
//    }
}
