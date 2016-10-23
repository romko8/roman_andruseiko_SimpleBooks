//
//  UIImageView+ImageDownloading.swift
//  roman_andruseiko_SimpleBooks
//
//  Created by Roman Andruseiko on 10/23/16.
//  Copyright © 2016 SimpleBooks. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageDownloadedFrom(link: String) {
        self.image = nil
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
        }.resume()
    }
}
