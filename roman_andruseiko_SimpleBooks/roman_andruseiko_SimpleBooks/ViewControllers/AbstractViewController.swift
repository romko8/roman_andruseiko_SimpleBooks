//
//  AbstractViewController.swift
//  roman_andruseiko_SimpleBooks
//
//  Created by Roman Andruseiko on 10/20/16.
//  Copyright © 2016 SimpleBooks. All rights reserved.
//

import UIKit

class AbstractViewController: UIViewController {

    func pushViewControllerWithIdentifier(storyboardID: String) {
        let genresViewController = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardID)
        self.navigationController?.pushViewController(genresViewController!, animated: true)
    }
}
