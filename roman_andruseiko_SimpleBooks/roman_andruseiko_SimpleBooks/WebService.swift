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
    
    fileprivate func makeRequest(_ method:String, url:String, completion: @escaping (_ response: NSDictionary?, _ error: Error?) -> Void) {
        let storeURL: URL = URL(string: url)!
        var request: URLRequest = URLRequest(url: storeURL)
        request.httpMethod = method

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                if error != nil {
                    completion(nil, error)
                } else {
                    let jsonResponse: NSDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    completion(jsonResponse, nil)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func getGenres( _ completion: @escaping (_ genres: [Genre]?) -> Void) {
        makeRequest("GET", url: booksAPIServerURL + "lists/names.json?api-key=" + booksAPIKey) { (response, error) in
            if error == nil && response != nil {
                if let results = response?.object(forKey: "results") as? [[String : AnyObject]]{
                    var genres:[Genre] = []
                    for genreDictionary in results {
                        let genre = Genre.init(dictionary: genreDictionary)
                        genres.append(genre)
                    }
                    completion(genres)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func getBestsellers(_ genre:String) {
        makeRequest("GET", url: booksAPIServerURL + "lists/names.json?api-key=" + booksAPIKey + "?list=" + genre) { (response, error) in
            print("response - \(response)")
        }
    }
    
    func getCoverImageURL(_ isbn: String) -> String {
        let imageUrl = "http://images.amazon.com/images/P/\(isbn).01.20TRZZZZ.jpg"
        return imageUrl
    }
}
