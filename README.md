# NoteApp

A simple **Note App** built with **SwiftUI**, **MVVM architecture**, and **Core Data** for local storage. Supports adding, updating, deleting, and listing notes with timestamps. Includes unit tests for repository functions.

---

## Features

- List notes with title and timestamp.  
- Add new notes with title and description.  
- Edit/update existing notes.  
- Delete notes.  
- Timestamp formatted as `dd MMM yyyy, HH:mm`.  
- Core Data local persistence.  
- MVVM architecture separating **View**, **ViewModel**, and **Repository**.  
- Async/await used for all repository operations.  
- Unit tests using **XCTest** with in-memory Core Data.

## Setup Instructions

1. **Clone the repository**  
```bash
git clone https://github.com/sreysros/NoteApp.git
cd NoteApp
```

2. **Open the project in Xcode**  
- Make sure you have **Xcode 14.3+** (supports Swift async/await).  
- Open `NoteApp.xcodeproj`.

3. **Select a personal development team**  
- Go to `NoteAppApp` target → Signing & Capabilities → Select your personal team.  
- Change bundle identifier if needed (`com.yourname.NoteApp`) to avoid conflicts.

4. **Run the app**  
- Build and run on a simulator or device.  
- The main screen shows a list of notes.  
- Tap the **+** button to add a note.  
- Tap a note to edit/update.  
- Swipe or use delete button to remove notes.

5. **Run Unit Tests**  
- Select the `NoteAppTests` scheme.  
- Press **Cmd+U** to run all repository unit tests.  
- Tests use an **in-memory Core Data stack**, so they don’t affect your real data.

---

## Approach / Architecture

- **MVVM Pattern**:  
  - `View`: Handles UI and user interaction (`HomeScreen`, `AddNewNoteScreen`).  
  - `ViewModel`: Handles business logic, exposes async methods for the view (`HomeViewModel`).  
  - `Repository`: Encapsulates Core Data operations (`NoteRepositoryImpl`) for fetching, saving, updating, and deleting notes.  

- **Core Data**:  
  - `Item` is the entity storing `title`, `noteDescription`, `timestamp`, and `id`.  
  - `PersistenceController` provides a shared `NSPersistentContainer`.  
  - Unit tests use **in-memory Core Data** to ensure isolation.  

- **Async/Await**:  
  - All repository methods (`fetchNotesList`, `saveNote`, `updateNote`, `deleteNote`) are async.  
  - ViewModel uses `Task` to call these methods from SwiftUI views.  

- **Reusability**:  
  - `AddNewNoteScreen` can be used for **both adding and editing notes** by passing an optional note.  
  - Timestamps are formatted using `DateFormatter` (`dd MMM yyyy, HH:mm`).  

- **Testing**:  
  - Unit tests cover repository CRUD operations.  
  - Mock or in-memory repository ensures **tests are deterministic** and do not touch real Core Data.

---
