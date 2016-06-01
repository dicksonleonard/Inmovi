//
//  MovieCell.swift
//  inmovi
//
//  Created by Alfonse MBP 00 on 5/17/16.
//  Copyright © 2016 Alvonse. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageCoverView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    
    var inspiration: Inspiration? {
        didSet {
            if let inspiration = inspiration {
                imageView.image = inspiration.backgroundImage
                titleLabel.text = inspiration.title
                subtitleLabel.text = inspiration.speaker
            }
        }
    }
    
    var movie: Movie? {
        didSet {
            if let movie = movie {
                titleLabel.text = movie.title
                subtitleLabel.text = "huahaha"
                imageView.image = UIImage(named: "Inspiration-01")
                
                Alamofire.request(.GET, movie.imageURL!).responseImage { response in
                    debugPrint(response)
                    
                    print(response.request)
                    print(response.response)
                    debugPrint(response.result)
                    
                    if let image = response.result.value {
                        print("image downloaded: \(image)")
                        self.imageView.image = image
                    }

                }
            }
        }
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        let standardHeight = MovieLayoutConstants.Cell.standardHeight
        let featuredHeight = MovieLayoutConstants.Cell.featuredHeight
        
        let delta = 1 - ((featuredHeight - CGRectGetHeight(frame)) / (featuredHeight - standardHeight))
        
        let minAlpha: CGFloat = 0.3
        let maxAlpha: CGFloat = 0.75
        imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        let scale = max(delta, 0.5)
        titleLabel.transform = CGAffineTransformMakeScale(scale, scale)
        
        subtitleLabel.alpha = delta
    }

}
