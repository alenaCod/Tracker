//
//  CoreDataManager.swift
//  Trakkers
//
//  Created by Svitlana Moiseyenko on 9/17/17.
//  Copyright © 2017 Nicholas. All rights reserved.
//

//import Foundation
//import CoreData
//
//final class CoreDataManagerTest {
// 
//    private lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "Tracker")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error {
//                fatalError("Unresolved error \(error)")
//            }
//            //container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//        })
//        return container
//    }()
//    
//    static let sharedInstance = CoreDataManagerTest()
//    private var mainContext: NSManagedObjectContext!
//    private var privateContext: NSManagedObjectContext!
//    
//    private init() {
//        self.mainContext = persistentContainer.viewContext
//        self.privateContext = persistentContainer.newBackgroundContext()
//        
//        // Add Observer
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(forName: .NSManagedObjectContextObjectsDidChange, object: nil, queue: nil) { note in
//            self.privateContext.perform({
//                self.privateContext.mergeChanges(fromContextDidSave: note) //TODO: think to remove
//            })
//        }
//    }
//
//    func createCuncurrentContext() -> NSManagedObjectContext {
//        return persistentContainer.newBackgroundContext()
//    }
//
//  func getDevices(filter: String? = nil, completion: @escaping (_ deviceType: [DeviceTest])->()) {
//      privateContext.perform {
//        let request = DeviceTest.sortedFetchRequest
//        request.returnsObjectsAsFaults = false
//        if let _filter = filter {
//          let predicate = NSPredicate(format: "testLocation CONTAINS[cd] %@", _filter)
//          request.predicate = predicate
//        }
//        let deviceTypes: [DeviceTest] = try! self.privateContext.fetch(request)
//        completion(deviceTypes)
//      }
//    }
//  
//    func saveDevices(completion: @escaping ()->()) {
//        privateContext.perform {
//            for i in 0...25 {
//              let dic = ["id": i, "test_location": CoreDataManagerTest.getLocation(), "test_logo": CoreDataManagerTest.getImage()] as [String : Any]
//              DeviceTest.insert(into: self.privateContext, data: dic)
//            }
//            self.privateContext.performChanges(block: {
//                completion()
//            })
//        }
//    }
//  
//    func clearData() {
//        let managedObjectContext = persistentContainer.viewContext
//        //clearAllEntitiesByName("DeviceType", context: managedObjectContext)
//        clearAllEntitiesByName("DeviceTest", context: managedObjectContext)
//        //clearAllEntitiesByName("Location", context: managedObjectContext)
//        //clearAllEntitiesByName("Summary", context: managedObjectContext)
//        //clearAllEntitiesByName("Stats", context: managedObjectContext)
//    }
//  
//    func clearAllEntitiesByName(_ name: String, context: NSManagedObjectContext) {
//      //context.performAndWait({
//      let managedObjectContext = persistentContainer.viewContext
//      let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: name)
//      let request = NSBatchDeleteRequest(fetchRequest: fetch)
//      let result = try? managedObjectContext.execute(request)
//      print("Delete result: ", result)
//      //})
//    }
//}
//
//
//extension CoreDataManagerTest {
//    static func getImage() -> String {
//      let random =  Int(arc4random_uniform(UInt32(images.count)))
//      return images[random]
//    }
//  
//  static func getLocation() -> String {
//    let random =  Int(arc4random_uniform(UInt32(locations.count)))
//    return locations[random]
//  }
//  
//  static let images = [
//    "https://trakkers-dev-static.s3.amazonaws.com/media/logos/device%20types/5.png?AWSAccessKeyId=AKIAIPXC42PRYUGHFONA&Signature=xvRRhyZEsIT5gxo81kg74Xrvaa0%3D&Expires=1511892394",
//    "https://trakkers-dev-static.s3.amazonaws.com/media/logos/device%20types/2.png?AWSAccessKeyId=AKIAIPXC42PRYUGHFONA&Signature=j7NHLbBVCxNBVbf2uRMF7s370Wc%3D&Expires=1511892394",
//    "https://trakkers-dev-static.s3.amazonaws.com/media/logos/device%20types/6.png?AWSAccessKeyId=AKIAIPXC42PRYUGHFONA&Signature=%2FuPeSI%2FYJkdz7t9DujQrFzkgs84%3D&Expires=1511892394"
//                 ]
//  
//   static let locations = ["Corridor", "Room 102", "Room 101", "Room 132"]
//}
