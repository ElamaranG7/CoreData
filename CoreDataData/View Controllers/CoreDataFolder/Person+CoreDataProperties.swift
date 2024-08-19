//
//  Person+CoreDataProperties.swift
//  CoreDataData
//
//  Created by SAIL on 31/07/24.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var emailId: String?

}

extension Person : Identifiable {

}
