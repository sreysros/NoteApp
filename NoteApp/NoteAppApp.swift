//
//  NoteAppApp.swift
//  NoteApp
//
//  Created by sreysros.leak on 3/10/25.
//

import SwiftUI
import CoreData

@main
struct NoteAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
