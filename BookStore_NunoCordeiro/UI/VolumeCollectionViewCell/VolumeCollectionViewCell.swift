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
    
    @IBOutlet weak var favImageView: UIImageView!
    
    func configure(volumeInfo: VolumeInfo) {
        
        titleLabel.text = volumeInfo.title
        titleLabel.textColor = .primary
        if let thumbnailURL = volumeInfo.imageLinks?.thumbnail {
            imageView.load(urlString: thumbnailURL)
        }
        self.contentView.addDropShadow()
        favImageView.isHidden = !AppConstants.shared.favoriteVolumes.contains(where: {$0.volumeInfo?.title == volumeInfo.title})
        let heartImage = UIImage(systemName: "heart.circle.fill")!.withRenderingMode(.alwaysOriginal)
        favImageView.image = heartImage
        
        
    }
}
