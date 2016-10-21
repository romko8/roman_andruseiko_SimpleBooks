//
//  GenresViewController.swift
//  roman_andruseiko_SimpleBooks
//
//  Created by Roman Andruseiko on 10/20/16.
//  Copyright © 2016 SimpleBooks. All rights reserved.
//

import UIKit

class GenresViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [Genre] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WebService.sharedInstance.getGenres { (genres) in
            print("count - \(genres?.count)")
            self.dataSource = genres ?? []
            
            self.tableView.reloadData()
        }
//        WebService.sharedInstance.getBestsellers("Family")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension GenresViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        let genre = dataSource[indexPath.row]
        cell.textLabel?.text = genre.name
        return cell
    }
}
