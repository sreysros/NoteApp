//
//  SaveNoteUseCase.swift
//  NoteApp
//
//  Created by sreysros.leak on 5/10/25.
//

import Foundation

struct SaveNoteUseCase {
    private let repo: NoteRepository
    
    init(repo: NoteRepository) {
        self.repo = repo
    }
    
    func execute(title: String, description: String?) async throws {
        do {
            try await repo.saveNote(title: title, description: description)
        } catch {
            throw error
        }
        
    }
}
