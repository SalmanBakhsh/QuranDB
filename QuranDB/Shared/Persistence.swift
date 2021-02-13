//
//  Persistence.swift
//  Shared
//
//  Created by Salman Bakhsh on 11/20/20.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for x in 0..<2 {
            
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "QuranDB")
        if inMemory {
            print("inMemory")
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        let bundleFileURL = Bundle.main.bundleURL.appendingPathComponent("DataModel").appendingPathComponent("SQLite").appendingPathComponent("QuranDB").appendingPathExtension("sqlite")
        let currentPersistentStoreURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0].appendingPathComponent("QuranDB").appendingPathExtension("sqlite")
        print("bundleFileURL: \(bundleFileURL)")
        print("currentPersistentStoreURL: \(currentPersistentStoreURL)")
        
        do {
            if FileManager.default.fileExists(atPath: currentPersistentStoreURL.path)==false {
                print("File not Exists")
                print("trying replacePersistentStore")
                try container.persistentStoreCoordinator.replacePersistentStore(at: currentPersistentStoreURL, destinationOptions: nil, withPersistentStoreFrom: bundleFileURL, sourceOptions: nil, ofType: NSSQLiteStoreType)
                print("replacePersistentStore")
            } else {
                print("File Exists")
                print("getting file size")
                let fileAttribute = try FileManager.default.attributesOfItem(atPath: currentPersistentStoreURL.path)
                let fileSize = fileAttribute[FileAttributeKey.size] as! Int
                print("fileSize= \(fileSize)")
                if fileSize < 10000000 {
                    print("trying replacePersistentStore")
                    try container.persistentStoreCoordinator.replacePersistentStore(at: currentPersistentStoreURL, destinationOptions: nil, withPersistentStoreFrom: bundleFileURL, sourceOptions: nil, ofType: NSSQLiteStoreType)
                    print("replacePersistentStore")
                }
            }
        } catch {
            print("Errorrrrrrrrrrrr: \(error)")
        }
        
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
