//
//  ContentView.swift
//  NoteApp
//
//  Created by sreysros.leak on 3/10/25.
//

import SwiftUI
import CoreData

struct HomeScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var vm = HomeViewModel()

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State var searchText: String = ""
    @State private var addNewScreen = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "f2f2f7")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                       
                List {
                    ForEach(0..<vm.notes.count, id: \.self) { index in
                        let item = vm.notes[index]
                        if let title = item.title, !title.isEmpty {
                            
                            NavigationLink {
                                AddNewNoteScreen(note: vm.notes[index])
                                    .environmentObject(vm)
                            } label: {
                                HStack {
                                    Text(title)
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.black)
                                    Spacer()
                                    Text(item.timestamp ?? Date(), formatter: itemFormatter)
                                        .font(.system(size: 12))
                                }
                                
                            }
                        }
                        
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationTitle("Notes")
                .navigationBarTitleDisplayMode(.automatic)
                }
                
                NavigationLink {
                    AddNewNoteScreen()
                        .environmentObject(vm)
                } label: {
                    Image("edit")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                        .tint(Color.orange)
                        .padding()
                        .shadow(radius: 4)
                }
                
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)

            }
        }
    }

    private func addItem(title: String, description: String?) {
        withAnimation {
            Task {
                await vm.saveNote(title: title, description: description ?? "")
            }
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
        }
    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            Task {
//                await vm.deleteNote(id: <#T##UUID#>)
//            }
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            // Capture IDs first, then update local array
            let idsToDelete: [UUID] = offsets.compactMap { index in
                vm.notes[index].id
            }
            
            // Call your async deletion for each note
            Task {
                for id in idsToDelete {
                    await vm.deleteNote(id: id)
                }
            }
            
            // Update the UI immediately
            vm.notes.remove(atOffsets: offsets)
        }
    }
}



#Preview {
    HomeScreen().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(HomeViewModel())
}
