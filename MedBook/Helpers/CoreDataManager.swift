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
}
