//
//  GenresViewController.swift
//  roman_andruseiko_SimpleBooks
//
//  Created by Roman Andruseiko on 10/20/16.
//  Copyright © 2016 SimpleBooks. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class GenresViewController: AbstractViewController {
    
    var dataSource: [Genre] = []
    var refreshControl: UIRefreshControl!
    var selectedGenre: Genre?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildUI()
        refreshData(sender: nil)
    }
    
    func buildUI() {
        let leftBarButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(GenresViewController.logOutButtonPressed))
        self.tabBarController?.navigationItem.leftBarButtonItem = leftBarButton
        self.tabBarController?.navigationItem.title = "SimpleBooks"
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
        refreshControl.addTarget(self, action: #selector(GenresViewController.refreshData(sender:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func refreshData(sender:AnyObject?) {
        WebService.sharedInstance.getGenres { (genres) in
            self.dataSource = genres ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
                sender?.endRefreshing()
            }
        }
    }
    
    func logOutButtonPressed() {
        let alert = UIAlertController(title: "Message", message: "Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (action) in
            FBSDKLoginManager.init().logOut()
            FBSDKAccessToken.setCurrent(nil)
            
            CoreDataManager.sharedInstance.removeUsers()
            
            _ = self.navigationController?.popToRootViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController: BestsellersViewController = segue.destination as! BestsellersViewController
        destinationViewController.genre = selectedGenre
    }
}

extension GenresViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let genre = dataSource[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = genre.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let genre = dataSource[(indexPath as NSIndexPath).row]
        selectedGenre = genre
        self.performSegue(withIdentifier: "bestsellersControllerSegue", sender: nil)
    }
}
