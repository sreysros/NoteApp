//
//  FetchNotesListUseCase.swift
//  NoteApp
//
//  Created by sreysros.leak on 5/10/25.
//

import Foundation

struct FetchNotesListUseCase {
    private let repo: NoteRepository
    
    init(repo: NoteRepository) {
        self.repo = repo
    }
    
    func execute() async throws -> [Item] {
        do {
            let result = try await repo.fetchNotesList()
            return result
        } catch {
            throw error
        }
    }
}
