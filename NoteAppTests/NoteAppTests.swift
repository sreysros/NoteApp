//
//  NoteAppTests.swift
//  NoteAppTests
//
//  Created by sreysros.leak on 3/10/25.
//

import XCTest
import CoreData
@testable import NoteApp

@MainActor
class NoteViewModelTests: XCTestCase {
    class NoteTestRepository: NoteRepository {
        let context: NSManagedObjectContext
        var notes: [Item] = []
        
        init(context: NSManagedObjectContext) {
            self.context = context
        }
        
        func fetchNotesList() async throws -> [Item] {
            notes
        }
        
        func saveNote(title: String, description: String?) async throws {
            let note = Item(context: context) // ✅ must use context
            note.id = UUID()
            note.title = title
            note.noteDescription = description
            note.timestamp = Date()
            notes.append(note)
        }
        
        func updateNote(id: UUID, title: String, description: String?) async throws {
            guard let index = notes.firstIndex(where: { $0.id == id }) else { return }
            notes[index].title = title
            notes[index].noteDescription = description
            notes[index].timestamp = Date()
        }
        
        func deleteNote(id: UUID) async throws {
            notes.removeAll { $0.id == id }
        }
    }
    
    // MARK: - Tests
    func testUpdateNote() async throws {
        let context = TestPersistenceController.shared.container.viewContext
        let repo = NoteTestRepository(context: context)
        
        try await repo.saveNote(title: "Old Title", description: "Old Description")
        let note = try await repo.fetchNotesList().first!
        
        try await repo.updateNote(id: note.id ?? UUID(), title: "New Title", description: "New Description")
        
        let updatedNote = try await repo.fetchNotesList().first!
        XCTAssertEqual(updatedNote.title, "New Title")
        XCTAssertEqual(updatedNote.noteDescription, "New Description")
    }

    
}




