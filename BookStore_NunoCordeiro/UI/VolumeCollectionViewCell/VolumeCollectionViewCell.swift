//
//  VolumeCollectionViewCell.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 05/04/2023.
//

import UIKit

class VolumeCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(volumeInfo: VolumeInfo) {
        
        titleLabel.text = volumeInfo.title
        if let thumbnailURL = volumeInfo.imageLinks?.smallThumbnail {
            imageView.load(urlString: thumbnailURL)
        }
        self.contentView.addDropShadow()
        self.clipsToBounds = false
    }
}
