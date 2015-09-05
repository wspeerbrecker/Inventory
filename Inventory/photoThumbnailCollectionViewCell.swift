//
//  photoThumbnailCollectionViewCell.swift
//  Inventory
//
//  Created by Admin on 2015-07-25.
//  Copyright (c) 2015 infoshare. All rights reserved.
//

import UIKit

class photoThumbnailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    func setThumbnailImage(thumbnailImage: UIImage)
    {
        self.imgView.image = thumbnailImage
    }
}
