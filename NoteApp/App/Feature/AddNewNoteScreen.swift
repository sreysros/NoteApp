//
//  NewNoteScreen.swift
//  NoteApp
//
//  Created by sreysros.leak on 3/10/25.
//

import SwiftUI

struct AddNewNoteScreen: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var homeVM: HomeViewModel
    @State var title: String = ""
    @State var description: String = ""
    @State private var showAlert = false
    
    let noteToEdit: Item?
    
    init(note: Item? = nil) {
        self.noteToEdit = note
        _title = State(initialValue: note?.title ?? "")
        _description = State(initialValue: note?.noteDescription ?? "")
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                if title.isEmpty && noteToEdit?.title == nil {
                    Text("Title")
                        .font(.system(size: 28, weight: .semibold))
                        .opacity(0.2)
                }
                TextField("", text: $title)
                    .font(.system(size: 28, weight: .semibold))
            }
            
            ZStack(alignment: .topLeading) {
                if description.isEmpty && noteToEdit?.noteDescription == nil {
                    Text("Description")
                        .font(.system(size: 16, weight: .medium))
                        .opacity(0.2)
                }
                TextEditor(text: $description)
                    .font(.system(size: 16, weight: .medium))
                
            }
        }
        
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAlert = title.isEmpty
                    Task {
                        if noteToEdit != nil {
                            let id = noteToEdit?.id
                            await homeVM.updateNote(id: id ?? UUID(), title: title, description: description)
                        } else {
                            await homeVM.saveNote(title: title, description: description)
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        dismiss()
                    }
                } label: {
                    Image("ic_check")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
            }
        })
        .padding(.horizontal)
        .alert("Info", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Title is required")
        }
        
    }
}

#Preview {
    AddNewNoteScreen()
}
