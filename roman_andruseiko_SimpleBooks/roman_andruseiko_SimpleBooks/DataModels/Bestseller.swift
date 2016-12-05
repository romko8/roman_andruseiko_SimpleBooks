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
        if let bookDetails = dictionary["book_details"] as? [[String : AnyObject]] {
            if let bookDetail = bookDetails.first {
                self.authorName = bookDetail["author"] as? String ?? ""
                self.name = bookDetail["title"] as? String ?? ""
            }
        }
        
        self.rank = dictionary["rank"] as? Int ?? 0

        if let isbns = dictionary["isbns"] as? [[String : AnyObject]] {
            self.isbnCode = isbns.first?["isbn10"] as? String ?? String.randomString(length: 10)
        }

        self.amazonURL = dictionary["amazon_product_url"] as? String ?? ""
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
