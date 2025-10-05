//
//  NoteRepositoryImpl.swift
//  NoteApp
//
//  Created by sreysros.leak on 5/10/25.
//

import CoreData

class NoteRepositoryImpl: NoteRepository {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }
    
    func fetchNotesList() async throws -> [Item] {
        return try await context.perform {
            let request: NSFetchRequest<Item> = Item.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
            return try self.context.fetch(request)
        }
    }
    
    func saveNote(title: String, description: String?) async throws {
        await context.perform {
            let model = Item(context: self.context)
            model.id = UUID()
            model.title = title
            model.noteDescription = description ?? ""
            model.timestamp = Date()
        }
        try await saveContext()
    }
    
    func updateNote(id: UUID, title: String, description: String?) async throws {
        try await context.perform {
            let request: NSFetchRequest<Item> = Item.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            
            if let note = try self.context.fetch(request).first {
                note.title = title
                note.noteDescription = description ?? ""
                note.timestamp = Date()
            }
        }
        try await saveContext()
    }
    
    func deleteNote(id: UUID) async throws {
        try await context.perform {
            let request: NSFetchRequest<Item> = Item.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            
            if let note = try self.context.fetch(request).first {
                self.context.delete(note)
            }
        }
        try await saveContext()
    }
    
    private func saveContext() async throws {
        try await context.perform {
            if self.context.hasChanges {
                try self.context.save()
            }
        }
    }
}

