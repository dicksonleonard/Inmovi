//
//  MovieListController.swift
//  inmovi
//
//  Created by Alfonse MBP 00 on 5/16/16.
//  Copyright © 2016 Alvonse. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MovieCell"

class MovieListController: UICollectionViewController {

    let inspirations = Inspiration.allInspirations()
    let colors = UIColor.palette()
    
    let transitionDelegate: TransitioningDelegate = TransitioningDelegate()

    /* Change status bar color to white */
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = .None
        collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }
    
}

extension MovieListController {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inspirations.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MovieCell
        
        cell.inspiration = inspirations[indexPath.item]
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailPageController = storyboard?.instantiateViewControllerWithIdentifier("DetailPageController") as! DetailPageController

        let pageContentController = MovieDetailController()
        let contentViewControllers = [pageContentController]
        
        detailPageController.setViewControllers(contentViewControllers, direction: UIPageViewControllerNavigationDirection .Forward, animated: false, completion: nil)
        navigationController!.pushViewController(detailPageController, animated: true)
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