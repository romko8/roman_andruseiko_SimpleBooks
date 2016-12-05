//
//  Genre.swift
//  roman_andruseiko_SimpleBooks
//
//  Created by Roman Andruseiko on 10/21/16.
//  Copyright © 2016 SimpleBooks. All rights reserved.
//

import Foundation

class Genre: NSObject {
    var name: String?
    var encodedName: String?

    init (dictionary: [String : AnyObject]) {
        self.name = dictionary["display_name"] as? String ?? ""
        self.encodedName = dictionary["list_name_encoded"] as? String ?? ""
    }
}
