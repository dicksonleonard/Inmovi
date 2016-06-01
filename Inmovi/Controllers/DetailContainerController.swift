//
//  DetailContainerController.swift
//  Inmovi
//
//  Created by Alfonse MBP 00 on 5/20/16.
//  Copyright © 2016 Alvonse. All rights reserved.
//

import UIKit

class DetailContainerController: UIViewController {

    var detailPageController: UIPageViewController!
    var movies: [Movie] = []
    var currentPageIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .None
        /* Page views */
        detailPageController = UIPageViewController(transitionStyle: .Scroll,
                                                    navigationOrientation: .Horizontal,
                                                    options: nil)
        detailPageController.view.frame = view.frame
        detailPageController.delegate = self
        detailPageController.dataSource = self
        
        // Page view gesture recognizer must prioritize navigation controller's interactive pop gesture
//        for view in self.detailPageController!.view.subviews {
//            if let scrollView = view as? UIScrollView {
//                scrollView.panGestureRecognizer.requireGestureRecognizerToFail(self.navigationController!.interactivePopGestureRecognizer!);
//            }
//        }
        
        // Setup initial view controller
        let movieDetailController = storyboard?.instantiateViewControllerWithIdentifier("MovieDetailController") as! MovieDetailController
//        let testView = movieDetailController.view
        movieDetailController.movie = movies[currentPageIndex!]
        movieDetailController.pageIndex = currentPageIndex!
        let contentViewControllers = [movieDetailController]
        
        detailPageController.setViewControllers(contentViewControllers, direction: UIPageViewControllerNavigationDirection .Forward, animated: false, completion: nil)
        addChildViewController(detailPageController)
        view.insertSubview(detailPageController.view, atIndex: 0)
        detailPageController.didMoveToParentViewController(self)
    }
    
    @IBAction func goToPreviousPage(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }

}

extension DetailContainerController: UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    func pageViewController(_pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let visiblePageController = viewController as! MovieDetailController
        let visibleIndex = visiblePageController.pageIndex
        
        if (visibleIndex == 0 || visibleIndex == NSNotFound) {
            return nil
        }
        else {
            let leftMovieController = storyboard?.instantiateViewControllerWithIdentifier("MovieDetailController") as! MovieDetailController
            leftMovieController.movie = movies[visibleIndex - 1]
            leftMovieController.pageIndex = visibleIndex - 1
            return leftMovieController
        }
    }
    
    func pageViewController(_pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let visiblePageController = viewController as! MovieDetailController
        let visibleIndex = visiblePageController.pageIndex
        
        if (visibleIndex == (movies.count + 1) || visibleIndex == NSNotFound) {
            return nil
        }
        else {
            let rightMovieController = storyboard?.instantiateViewControllerWithIdentifier("MovieDetailController") as! MovieDetailController
            rightMovieController.movie = movies[visibleIndex + 1]
            rightMovieController.pageIndex = visibleIndex + 1
            return rightMovieController
        }
    }
    
}
