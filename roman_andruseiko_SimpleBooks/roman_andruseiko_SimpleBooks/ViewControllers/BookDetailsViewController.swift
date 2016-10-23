//
//  BookDetailsViewController.swift
//  roman_andruseiko_SimpleBooks
//
//  Created by Roman Andruseiko on 10/20/16.
//  Copyright © 2016 SimpleBooks. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {
    var bestseller: Bestseller?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("bestseller - \(bestseller?.name)")
        print("isbnCode - \(bestseller?.isbnCode)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
