//
//  TestPersistenceController.swift
//  NoteApp
//
//  Created by sreysros.leak on 5/10/25.
//


import CoreData
@testable import NoteApp

class TestPersistenceController {
    static let shared = TestPersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "NoteApp")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { desc, error in
            if let error = error {
                fatalError("Failed to load in-memory store: \(error)")
            }
        }
    }
}
