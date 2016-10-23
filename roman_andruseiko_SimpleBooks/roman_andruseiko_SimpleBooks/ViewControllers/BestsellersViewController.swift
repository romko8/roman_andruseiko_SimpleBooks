//
//  BestsellersViewController.swift
//  roman_andruseiko_SimpleBooks
//
//  Created by Roman Andruseiko on 10/20/16.
//  Copyright © 2016 SimpleBooks. All rights reserved.
//

import UIKit

class BestsellersViewController: AbstractViewController {
    var genre:Genre?
    
    var dataSource: [AnyObject] = []
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "BestsellerCustomCell", bundle: nil), forCellReuseIdentifier: "BestsellerCustomCell")
    
        buildUI()
        refreshData(sender: nil)
    }
    
    func buildUI() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
        refreshControl.addTarget(self, action: #selector(GenresViewController.refreshData(sender:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func refreshData(sender:AnyObject?) {
WebService.sharedInstance.getBestsellers((genre?.encodedName)!) { (bestsellers) in
            self.dataSource = bestsellers ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
                sender?.endRefreshing()
            }
        }
    }
    
}

extension BestsellersViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BestsellerCustomCell", for: indexPath) as! BestsellerCustomCell
        let bestseller = dataSource[(indexPath as NSIndexPath).row] as! Bestseller
        cell.bookNameLabel.text = bestseller.name
        cell.authorLabel.text = bestseller.authorName
        cell.coverImageView.setImageDownloadedFrom(link: WebService.sharedInstance.getCoverImageURL(bestseller.isbnCode))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "bookDetailsViewController") as! BookDetailsViewController
        viewController.bestseller = dataSource[(indexPath as NSIndexPath).row] as? Bestseller
        self.navigationController?.pushViewController(viewController, animated: true)

    }
}

