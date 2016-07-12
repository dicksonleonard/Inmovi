//
//  MovieListController.swift
//  inmovi
//
//  Created by Alfonse MBP 00 on 5/16/16.
//  Copyright © 2016 Alvonse. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

private let reuseIdentifier = "MovieCell"

class MovieListController: UICollectionViewController, UIGestureRecognizerDelegate {

    let inspirations = Inspiration.allInspirations()
    let colors = UIColor.palette()
    var movies = [Movie]()
    
    
    let transitionDelegate: TransitioningDelegate = TransitioningDelegate()

    /* Change status bar color to white */
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = .None
        collectionView!.decelerationRate = UIScrollViewDecelerationRateFast

        Alamofire.request(.GET, "http://eagl.herokuapp.com/playingat/ambon", parameters:nil)
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        print("JSON: \(json)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
        
        Alamofire.request(.GET, "http://eagl.herokuapp.com/movie/json", parameters:nil)
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        print("JSON: \(json)")
                        
                        let realm = try! Realm()
                        
                        for (index,movieDatum):(String,JSON) in json {
                            print(index)
                            
                            let movie = Movie()
                            movie.id = movieDatum["id"].string
                            movie.title = movieDatum["title"].string
                            movie.summary = movieDatum["content"].string
                            movie.duration.value = movieDatum["duration"].int
                            movie.siteURL = movieDatum["url"].string
                            movie.imageURL = movieDatum["image"].string
                            movie.createdDate = movieDatum["createdAt"].string
                            movie.updatedDate = movieDatum["updatedAt"].string
                            self.movies.append(movie)
                            
                            // Load all image prematurely, save in cache
                            Alamofire.request(.GET, movie.imageURL!)
                            
                            try! realm.write {
                                realm.add(movie)
                            }
                        }
                        
                        self.collectionView?.reloadData()
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        // Enable swipe back when no navigation bar
        navigationController?.interactivePopGestureRecognizer!.delegate = self
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if(navigationController!.viewControllers.count > 1){
            return true
        }
        return false
    }
    
}

extension MovieListController {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MovieCell
        
        cell.movie = movies[indexPath.item]
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("DetailContainerController") as! DetailContainerController
        detailVC.movies = self.movies
        detailVC.currentPageIndex = indexPath.row
        navigationController!.pushViewController(detailVC, animated: true)
    }
}


// Temporary
extension UIColor {
    
    class func colorFromRGB(r: Int, g: Int, b: Int) -> UIColor {
        return UIColor(red: CGFloat(Float(r) / 255), green: CGFloat(Float(g) / 255), blue: CGFloat(Float(b) / 255), alpha: 1)
    }
    
    class func palette() -> [UIColor] {
        let palette = [
            UIColor.colorFromRGB(85, g: 0, b: 255),
            UIColor.colorFromRGB(170, g: 0, b: 170),
            UIColor.colorFromRGB(85, g: 170, b: 85),
            UIColor.colorFromRGB(0, g: 85, b: 0),
            UIColor.colorFromRGB(255, g: 170, b: 0),
            UIColor.colorFromRGB(255, g: 255, b: 0),
            UIColor.colorFromRGB(255, g: 85, b: 0),
            UIColor.colorFromRGB(0, g: 85, b: 85),
            UIColor.colorFromRGB(0, g: 85, b: 255),
            UIColor.colorFromRGB(170, g: 170, b: 255),
            UIColor.colorFromRGB(85, g: 0, b: 0),
            UIColor.colorFromRGB(170, g: 85, b: 85),
            UIColor.colorFromRGB(170, g: 255, b: 0),
            UIColor.colorFromRGB(85, g: 170, b: 255),
            UIColor.colorFromRGB(0, g: 170, b: 170)
        ]
        return palette
    }
    
}