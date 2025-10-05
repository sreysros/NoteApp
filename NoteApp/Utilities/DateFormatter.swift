//
//  DateFormatter.swift
//  NoteApp
//
//  Created by sreysros.leak on 5/10/25.
//
import Foundation

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
//    formatter.timeStyle = .short
    formatter.dateFormat = "dd MMM YYYY hh:mm a"
    return formatter
}()
