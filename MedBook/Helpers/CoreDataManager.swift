//
//  CoreDataManager.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//


import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "MedBook")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error) ")
            }
        }
    }

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Save User to Core Data
    func saveUser(email: String, password: String, country: String) {
        let user = UserEntity(context: context)
        user.email = email
        user.password = password
        user.country = country

        do {
            try context.save()
            print("User saved successfully!")
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }

    // MARK: - Fetch User by Email
    func fetchUser(email: String) -> UserEntity? {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)

        do {
            return try context.fetch(request).first
        } catch {
            print("Failed to fetch user: \(error.localizedDescription)")
            return nil
        }
    }

    // MARK: - Check if User Exists
    func isUserExists(email: String) -> Bool {
        return fetchUser(email: email) != nil
    }
    
    func saveBook(_ book: Book, forUser email: String) {
        let bookEntity = BookEntity(context: context)
        bookEntity.id = book.key
        bookEntity.title = book.title
        bookEntity.author = book.author_name?.first
        bookEntity.coverID = Int64(book.cover_i ?? 0)
        bookEntity.ratingAverage = book.ratings_average ?? 0.0
        bookEntity.ratingCount = Int64(book.ratings_count ?? 0)
        bookEntity.userEmail = email
        
        do {
            try context.save()
            print("Book saved successfully!")
        } catch {
            print("Failed to save book: \(error.localizedDescription)")
        }
    }
    
    // Fetch Bookmarks for a User
    func fetchBooks(forUser email: String) -> [Book] {
        let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        request.predicate = NSPredicate(format: "userEmail == %@", email)
        
        do {
            let bookEntities = try context.fetch(request)
            return bookEntities.map { $0.toBook() } // Convert to Book struct
        } catch {
            print("Failed to fetch books: \(error.localizedDescription)")
            return []
        }
    }

    
    // Check if a Book is Bookmarked
    func isBookmarked(_ book: Book, forUser email: String) -> Bool {
        let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@ AND userEmail == %@", book.key, email)
        
        do {
            return try context.fetch(request).count > 0
        } catch {
            print("Failed to check bookmark status: \(error.localizedDescription)")
            return false
        }
    }
    
    // Remove Book from Bookmarks
    func removeBook(_ book: Book, forUser email: String) {
        let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@ AND userEmail == %@", book.key, email)
        
        do {
            if let bookEntity = try context.fetch(request).first {
                context.delete(bookEntity)
                try context.save()
                print("Book removed successfully!")
            }
        } catch {
            print("Failed to remove book: \(error.localizedDescription)")
        }
    }
}
