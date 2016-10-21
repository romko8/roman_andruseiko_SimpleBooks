//
//  Book+CoreDataProperties.swift
//  roman_andruseiko_SimpleBooks
//
//  Created by Roman Andruseiko on 10/21/16.
//  Copyright © 2016 SimpleBooks. All rights reserved.
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book");
    }

    @NSManaged public var name: String?
    @NSManaged public var author: String?
    @NSManaged public var rank: String?
    @NSManaged public var amazonURL: String?
    @NSManaged public var user: User?

}
