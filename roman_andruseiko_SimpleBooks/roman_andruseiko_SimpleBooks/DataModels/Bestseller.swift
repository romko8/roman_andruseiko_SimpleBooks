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
    var imageData: NSData?
    
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
        } else {
            self.rank = 0
        }
        
        if dictionary["isbns"] != nil {
            let isbns = dictionary["isbns"] as? [[String : AnyObject]]
            if (isbns?.count)! > 0 && ((isbns?.first!["isbn10"]) != nil) {
                self.isbnCode = isbns?.first!["isbn10"] as? String
            } else {
                self.isbnCode = String.randomString(length: 10)
            }
        }
        
        if dictionary["amazon_product_url"] != nil {
            self.amazonURL = dictionary["amazon_product_url"] as? String
        }
    }
    
    init(book: Book) {
        self.name = book.name
        self.authorName = book.author
        self.rank = Int(book.rank!)!
        self.isbnCode = book.isbnCode
        self.amazonURL = book.amazonURL
        self.imageData = book.image
    }
}

extension String {
    static func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}
