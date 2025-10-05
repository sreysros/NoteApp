//
//  AddNewViewModel.swift
//  NoteApp
//
//  Created by sreysros.leak on 5/10/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class AddNewViewModel: ObservableObject {
    //-------------------------------
    //MARK: - Properties & Use Cases
    //-------------------------------
    private lazy var noteRepo = NoteRepositoryImpl()
    private lazy var retrieveNoteListUseCase = FetchNotesListUseCase(repo: noteRepo)
    private lazy var saveNoteUseCase = SaveNoteUseCase(repo: noteRepo)
    private lazy var updateNoteUseCase = UpdateNoteUseCas(repo: noteRepo)
    private lazy var deleteNoteUseCase = DeleteNoteUseCase(repo: noteRepo)
    
    @Published var notes: [Item] = []
    
    func saveNote(title: String, description: String) async {
        do {
            try await saveNoteUseCase.execute(title: title, description: description)
//            await retrieveNoteList()
        } catch {
            print("[Error]: Save Note")
        }
    }
    
    func updateNote(id: UUID, title: String, description: String) async {
        do {
            try await updateNoteUseCase.execute(id: id, title: title, description: description)
//            await retrieveNoteList()
        } catch {
            print("[Error]: Update Note")
        }
    }
    
}
