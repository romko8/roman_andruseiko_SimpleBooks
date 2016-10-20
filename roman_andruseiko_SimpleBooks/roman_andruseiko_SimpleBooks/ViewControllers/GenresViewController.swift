//
//  GenresViewController.swift
//  roman_andruseiko_SimpleBooks
//
//  Created by Roman Andruseiko on 10/20/16.
//  Copyright © 2016 SimpleBooks. All rights reserved.
//

import UIKit

class GenresViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        WebService.sharedInstance.getGenres()
        WebService.sharedInstance.getBestsellers("Family")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
