//
//  DetailContainerVC.swift
//  Inmovi
//
//  Created by Alfonse MBP 00 on 5/20/16.
//  Copyright © 2016 Alvonse. All rights reserved.
//

import UIKit

class DetailContainerVC: UIViewController {

    var pageViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageViewController = storyboard?.instantiateViewControllerWithIdentifier("DetailPageController") as! UIPageViewController
        pageViewController.view.frame = view.frame
        
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)
    }

}
