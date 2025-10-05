//
//  UpdateNoteUseCase.swift
//  NoteApp
//
//  Created by sreysros.leak on 5/10/25.
//

import Foundation

struct UpdateNoteUseCas {
    private let repo: NoteRepository
    
    init(repo: NoteRepository) {
        self.repo = repo
    }
    
    func execute(id: UUID, title: String?, description: String?) async throws {
        do {
            try await repo.updateNote(id: id, title: title ?? "", description: description ?? "")
        } catch {
            throw error
        }
        
    }
}
