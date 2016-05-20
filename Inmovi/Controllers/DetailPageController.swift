//
//  DetailPageController.swift
//  Inmovi
//
//  Created by Alfonse MBP 00 on 5/19/16.
//  Copyright © 2016 Alvonse. All rights reserved.
//

import UIKit

class DetailPageController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
    }
    
}

extension DetailPageController {
    
    func pageViewController(_pageViewController: UIPageViewController,
        viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
            let leftVC = MovieDetailController()
            leftVC.view.backgroundColor = .redColor()
            return leftVC
    }
    
    func pageViewController(_pageViewController: UIPageViewController,
        viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
            let rightVC = MovieDetailController()
            rightVC.view.backgroundColor = .blueColor()
            return rightVC
    }
    
}
