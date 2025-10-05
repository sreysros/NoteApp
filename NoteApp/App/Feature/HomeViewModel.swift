//
//  NoteViewModel.swift
//  NoteApp
//
//  Created by sreysros.leak on 5/10/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    //-------------------------------
    //MARK: - Properties & Use Cases
    //-------------------------------
    private lazy var noteRepo = NoteRepositoryImpl()
    private lazy var retrieveNoteListUseCase = FetchNotesListUseCase(repo: noteRepo)
    private lazy var saveNoteUseCase = SaveNoteUseCase(repo: noteRepo)
    private lazy var updateNoteUseCase = UpdateNoteUseCas(repo: noteRepo)
    private lazy var deleteNoteUseCase = DeleteNoteUseCase(repo: noteRepo)
    
    @Published var notes: [Item] = []
    
    
    
    init() {
        Task {
            await retrieveNoteList()
        }
    }
    
    func retrieveNoteList() async {
        do {
            notes = try await retrieveNoteListUseCase.execute()
        } catch {
            print("[Error]: Retrive Note List")
        }
    }
        
    func saveNote(title: String, description: String) async {
        do {
            try await saveNoteUseCase.execute(title: title, description: description)
            await retrieveNoteList()
        } catch {
            print("[Error]: Save Note")
        }
    }
    
    func updateNote(id: UUID, title: String, description: String) async {
        do {
            try await updateNoteUseCase.execute(id: id, title: title, description: description)
            await retrieveNoteList()
        } catch {
            print("[Error]: Update Note")
        }
    }
    
    func deleteNote(id: UUID) async {
        do {
            try await deleteNoteUseCase.execute(id: id)
            await retrieveNoteList()
        } catch {
            print("[Error]: Delete Note")
        }
    }
    
    func prefillData() {
        
    }
}


