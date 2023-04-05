//
//  UIImageView+Caching.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 05/04/2023.
//

import Foundation
import UIKit

var imageCache = NSCache<NSString, UIImage>()
extension UIImageView {

    /// Loads image to a UIImageView and caches it
    /// - Parameter urlString: Image Uri to be rendered and cached
    func load(urlString: String) {
        if let image = imageCache.object(forKey: urlString as NSString) {
            self.image = image
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let imageURL = URL(string: urlString),
               let data = try? Data(contentsOf: imageURL),let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: urlString as NSString)
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}

