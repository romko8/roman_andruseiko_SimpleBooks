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
    var filteredDataSource: [Bestseller] = []
    var refreshControl: UIRefreshControl!
    var searchActive : Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
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

extension BestsellersViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let bestsellers = dataSource.map{$0 as! Bestseller}
        filteredDataSource = bestsellers.filter{
        
        let name = $0.name ?? ""
        let authorName = $0.authorName ?? ""
            return name.range(of: searchText, options: .caseInsensitive)?.lowerBound != nil || authorName.range(of: searchText, options: .caseInsensitive)?.lowerBound != nil
        }
        if(filteredDataSource.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
}

extension BestsellersViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredDataSource.count
        }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BestsellerCustomCell", for: indexPath) as! BestsellerCustomCell
        let bestseller:Bestseller!
        if(searchActive) {
            bestseller = filteredDataSource[indexPath.row]
        } else {
            bestseller = dataSource[indexPath.row] as! Bestseller
        }
        
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
        if(searchActive) {
            viewController.bestseller = filteredDataSource[indexPath.row]
        } else {
            viewController.bestseller = dataSource[indexPath.row] as? Bestseller
        }
        
        self.navigationController?.pushViewController(viewController, animated: true)

    }
}

