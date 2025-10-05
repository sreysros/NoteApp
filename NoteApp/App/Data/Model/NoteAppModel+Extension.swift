//
//  NoteAppModel+Extension.swift
//  NoteApp
//
//  Created by sreysros.leak on 4/10/25.
//

import Foundation
import CoreData

extension Item {
    static func fetchRequestAll() -> NSFetchRequest<Item> {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)]
        return request
    }
}
