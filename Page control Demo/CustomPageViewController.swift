//
//  CustomViewController.swift
//  Page control Demo
//
//  Created by MAC241 on 17/05/22.
//

import UIKit

class CustomPageViewController: UIPageViewController {
    
    var individualPageViewControllerList = [UIViewController]()
    override func viewDidLoad() {
        dataSource = self
        super.viewDidLoad()
        individualPageViewControllerList = [
            PageViewController.getInstance(index: 0),
            PageViewController.getInstance(index: 1),
            PageViewController.getInstance(index: 2),
            PageViewController.getInstance(index: 3),
            PageViewController.getInstance(index: 4),
            PageViewController.getInstance(index: 5),
        ]
        
        setViewControllers([individualPageViewControllerList[0]], direction: .forward, animated: true, completion: nil)
    }
    
}

// MARK: - Page view controller datasource
extension CustomPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let indexOfCurrentPageViewController = individualPageViewControllerList.firstIndex(of: viewController)!
        if indexOfCurrentPageViewController == 0 {
            return nil
        } else {
            return individualPageViewControllerList[indexOfCurrentPageViewController - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let indexOfCurrentPageViewController = individualPageViewControllerList.firstIndex(of: viewController)!
        if indexOfCurrentPageViewController == individualPageViewControllerList.count - 1 {
            return nil
        } else {
            return individualPageViewControllerList[indexOfCurrentPageViewController + 1]
        }
    }
}
