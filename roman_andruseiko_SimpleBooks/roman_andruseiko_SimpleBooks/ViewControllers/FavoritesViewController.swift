//
//  FavoritesViewController.swift
//  roman_andruseiko_SimpleBooks
//
//  Created by Roman Andruseiko on 10/21/16.
//  Copyright © 2016 SimpleBooks. All rights reserved.
//

import UIKit

class FavoritesViewController: BestsellersViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData(sender: nil)
    }
    
    override func buildUI() {
    
    }
    
    override func refreshData(sender:AnyObject?) {
        self.dataSource = CoreDataManager.sharedInstance.getAllBooks() ?? []
        self.tableView.reloadData()
    }
}

extension FavoritesViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BestsellerCustomCell", for: indexPath) as! BestsellerCustomCell
        let book = dataSource[indexPath.row] as! Book
        cell.bookNameLabel.text = book.name
        cell.authorLabel.text = book.author
        if book.image != nil {
            cell.coverImageView.image = UIImage(data: book.image as! Data)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "bookDetailsViewController") as! BookDetailsViewController
        viewController.bestseller = Bestseller.init(book: (dataSource[indexPath.row] as? Book)!)
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
}
