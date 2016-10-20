//
//  WebService.swift
//  BooksApp
//
//  Created by Roman Andruseiko on 10/20/16.
//  Copyright © 2016 Books. All rights reserved.
//

import Foundation

class WebService: NSObject {
    let booksAPIKey = "0e795c8f9956400aaaeee0ad6f1a56c8"
    let booksAPIServerURL = "https://api.nytimes.com/svc/books/v3/"
    
    static let sharedInstance = WebService()
    
    private func makeRequest(method:String, url:String, completion: (response: NSDictionary?, error: NSError?) -> Void) {
        let storeURL: NSURL = NSURL(string: url)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: storeURL)
        request.HTTPMethod = method
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            do {
                if error != nil {
                    completion(response: nil, error: error)
                } else {
                    let jsonResponse: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                    completion(response: jsonResponse, error: nil)
                }
            } catch let error {
                print(error)
            }
        }).resume()
    }
    
    func getGenres() {
        makeRequest("GET", url: booksAPIServerURL + "lists/names.json?api-key=" + booksAPIKey) { (response, error) in
            print("response - \(response)")
        }
    }
    
    func getBestsellers(genre:String) {
        makeRequest("GET", url: booksAPIServerURL + "lists/names.json?api-key=" + booksAPIKey + "?list=" + genre) { (response, error) in
            print("response - \(response)")
        }
    }
    
    func getCoverImageURL(isbn: String) -> String {
        let imageUrl = "http://images.amazon.com/images/P/\(isbn).01.20TRZZZZ.jpg"
        return imageUrl
    }
}
