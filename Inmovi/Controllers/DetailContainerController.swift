//
//  DetailContainerController.swift
//  Inmovi
//
//  Created by Alfonse MBP 00 on 5/20/16.
//  Copyright © 2016 Alvonse. All rights reserved.
//

import UIKit

class DetailContainerController: UIViewController {

    var detailPageController: DetailPageController!
    
    @IBAction func goToPreviousPage(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Page views */
        
        detailPageController = storyboard?.instantiateViewControllerWithIdentifier("DetailPageController") as! DetailPageController
        detailPageController.view.frame = view.frame
        
        // Page view gesture recognizer must prioritize navigation controller's interactive pop gesture
        for view in self.detailPageController!.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.panGestureRecognizer.requireGestureRecognizerToFail(self.navigationController!.interactivePopGestureRecognizer!);
            }
        }
        
        // Setup initial view controller
        let pageContentController = MovieDetailController()
        let contentViewControllers = [pageContentController]
        
        detailPageController.setViewControllers(contentViewControllers, direction: UIPageViewControllerNavigationDirection .Forward, animated: false, completion: nil)
        
        addChildViewController(detailPageController)
        view.insertSubview(detailPageController.view, atIndex: 0)
        detailPageController.didMoveToParentViewController(self)
    }

}
