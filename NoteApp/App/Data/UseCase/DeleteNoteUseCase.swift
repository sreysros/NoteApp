//
//  DeleteNoteUseCase.swift
//  NoteApp
//
//  Created by sreysros.leak on 5/10/25.
//

import Foundation

struct DeleteNoteUseCase {
    private let repo: NoteRepository
    
    init(repo: NoteRepository) {
        self.repo = repo
    }
    
    func execute(id: UUID) async throws {
        do {
            try await repo.deleteNote(id: id)
        } catch {
            throw error
        }
    }
}
