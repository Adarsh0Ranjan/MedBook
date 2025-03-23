//
//  BookEntity+CoreDataProperties.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//
//

import Foundation
import CoreData


extension BookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var coverID: Int64
    @NSManaged public var ratingAverage: Double
    @NSManaged public var ratingCount: Int64
    @NSManaged public var userEmail: String?
    @NSManaged public var author: String?

}

extension BookEntity : Identifiable {

}
