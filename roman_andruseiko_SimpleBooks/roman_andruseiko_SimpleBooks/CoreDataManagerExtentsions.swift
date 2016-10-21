//
//  CoreDataManager.swift
//  roman_andruseiko_SimpleBooks
//
//  Created by Roman Andruseiko on 10/21/16.
//  Copyright © 2016 SimpleBooks. All rights reserved.
//

import Foundation
import CoreLocation

extension CoreDataManager {
    
    func createUser(id: String, name: String, token: String) -> User {
        let predicate = NSPredicate(format: "id = %@", id)
        let user : User = self.createEntity(predicate: predicate)
        user.facebookToken = token
        user.name = name
        self.saveContext(nil)
        return user
    }
    
    func isUserLoggedIn() -> Bool {
        let user : [User]? = self.objectsFromEntity(nil)
        return (user?.count)! > 0
    }
    
    func removeUsers() {
        self.deleteAllEntities(User.self)
        self.saveContext(nil)
    }
}
