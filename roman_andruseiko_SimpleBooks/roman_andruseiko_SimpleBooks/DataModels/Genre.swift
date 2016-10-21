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
        if dictionary["display_name"] != nil {
            self.name = dictionary["display_name"] as? String
        }
        if dictionary["list_name_encoded"] != nil {
            self.encodedName = dictionary["list_name_encoded"] as? String
        }
    }
}
