//
//  MovieDetailController.swift
//  Inmovi
//
//  Created by Alfonse MBP 00 on 5/19/16.
//  Copyright © 2016 Alvonse. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieDetailController: UIViewController {

    @IBOutlet private var headerImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    
    var movie: Movie?
    var pageIndex: Int = NSNotFound

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadMovieData()
    }
    
    func loadMovieData() {
        self.headerImageView.image = UIImage(named: "Inspiration-01")
        
        Alamofire.request(.GET, movie!.imageURL!).responseImage { response in
            if let image = response.result.value {
                self.headerImageView.image = image
            }
        }
        
        self.titleLabel.text = movie!.title
    }

}
