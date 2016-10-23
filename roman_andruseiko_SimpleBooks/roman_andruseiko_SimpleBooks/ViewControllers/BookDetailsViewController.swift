//
//  BookDetailsViewController.swift
//  roman_andruseiko_SimpleBooks
//
//  Created by Roman Andruseiko on 10/20/16.
//  Copyright © 2016 SimpleBooks. All rights reserved.
//

import UIKit
import FBSDKShareKit

class BookDetailsViewController: UIViewController {
    var bestseller: Bestseller?
    let facebookShareButton = FBSDKShareButton()
    
    @IBOutlet weak var amazonButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayData()
    }
    
    func displayData() {
        if  bestseller == nil {
            return
        }
        imageView.setImageDownloadedFrom(link: WebService.sharedInstance.getCoverImageURL(bestseller?.isbnCode))
        nameLabel.text = bestseller?.name
        authorLabel.text = bestseller?.authorName
        if (bestseller?.rank)! > 0 {
            rankLabel.text = "Rank: \((bestseller?.rank)!)"
        }
        if bestseller?.amazonURL != nil && (bestseller?.amazonURL?.characters.count)! > 0 {
            amazonButton.setTitle(bestseller?.amazonURL, for: .normal)
            amazonButton.titleLabel?.lineBreakMode = .byWordWrapping
            
            let content = FBSDKShareLinkContent()
            content.contentTitle = "SimpleBooks"
            content.contentURL = URL(string:(bestseller?.amazonURL)!)
            facebookShareButton.shareContent = content
            facebookShareButton.center = self.view.center
            self.view.addSubview(facebookShareButton)
            facebookShareButton.isHidden = true
        } else {
            amazonButton.isHidden = true
            shareButton.isHidden = true
        }
    }


    @IBAction func amazonButtonPressed(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: (bestseller?.amazonURL)!)!)
    }
    
    @IBAction func shareButtonPressed(_ sender: AnyObject) {
        facebookShareButton.sendActions(for: .touchUpInside)
    }
    
    @IBAction func likeButtonPressed(_ sender: AnyObject) {
    
    }
}
