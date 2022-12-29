//
//  Persistence.swift
//  Foodie
//
//  Created by Khayal Yediyarov on 29.12.22.
//

import CoreData
import UIKit

struct PersistenceController {

    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {

        container = NSPersistentContainer(name: "Foodie")

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in

            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } })
    } }
