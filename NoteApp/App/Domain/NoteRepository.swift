//
//  NoteRepository.swift
//  NoteApp
//
//  Created by sreysros.leak on 4/10/25.
//

import Foundation
import CoreData

@MainActor
protocol NoteRepository {
    func fetchNotesList() async throws -> [Item]
    func saveNote(title: String, description: String?) async throws
    func updateNote(id: UUID, title: String, description: String?) async throws
    func deleteNote(id: UUID) async throws
}
