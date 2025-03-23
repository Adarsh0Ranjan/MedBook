//
//  UserEntity+CoreDataProperties.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var country: String?

}

extension UserEntity : Identifiable {

}
