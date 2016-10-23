//
//  Bestseller.swift
//  roman_andruseiko_SimpleBooks
//
//  Created by Roman Andruseiko on 10/22/16.
//  Copyright © 2016 SimpleBooks. All rights reserved.
//

import Foundation

class Bestseller: NSObject {
    var name: String?
    var authorName: String?
    var rank: Int = -1
    var isbnCode: String?
    var amazonURL: String?
    
    init (dictionary: [String : AnyObject]) {        
        if dictionary["book_details"] != nil {
            let bookDetails = dictionary["book_details"] as? [[String : AnyObject]]
            if (bookDetails?.count)! > 0 {
                if (bookDetails?.first!["author"]) != nil {
                    self.authorName = bookDetails?.first!["author"] as? String
                }
                if (bookDetails?.first!["title"]) != nil {
                    self.name = bookDetails?.first!["title"] as? String
                }
            }
        }
        
        if dictionary["rank"] != nil {
            self.rank = (dictionary["rank"] as? Int)!
        }
        
        if dictionary["isbns"] != nil {
            let isbns = dictionary["isbns"] as? [[String : AnyObject]]
            if (isbns?.count)! > 0 && ((isbns?.first!["isbn10"]) != nil) {
                self.isbnCode = isbns?.first!["isbn10"] as? String
            }
        }
        
        if dictionary["amazon_product_url"] != nil {
            self.amazonURL = dictionary["amazon_product_url"] as? String
        }
    }
}
