//
//  MovieCell.swift
//  inmovi
//
//  Created by Alfonse MBP 00 on 5/17/16.
//  Copyright © 2016 Alvonse. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageCoverView: UIView!
    
    var inspiration: Inspiration? {
        didSet {
            if let inspiration = inspiration {
                imageView.image = inspiration.backgroundImage
            }
        }
    }

}
