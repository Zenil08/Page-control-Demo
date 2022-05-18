//
//  CustomViewController.swift
//  Page control Demo
//
//  Created by MAC241 on 17/05/22.
//

import UIKit

// MARK: - Page View Controller Delegate Protocol
protocol CustomPageViewControllerDelegate: AnyObject {
    func CustomPageViewController(CustomPageViewController: CustomPageViewController,
                                  didUpdatePageIndex index: Int)
}

class CustomPageViewController: UIPageViewController {
    
    private var individualPageViewControllerList = [UIViewController]()
    weak var customDelegate: CustomPageViewControllerDelegate?
    var selecteIndex = 0 {
        didSet {
            updatePage(selecteIndex: selecteIndex, oldIndex: oldValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPageViewController()
    }
    
    // Set up page view controller initial values
    fileprivate func setUpPageViewController() {
        dataSource = self
        delegate = self
        individualPageViewControllerList = [
            PageViewController.getInstance(index: 0),
            PageViewController.getInstance(index: 1),
            PageViewController.getInstance(index: 2),
            PageViewController.getInstance(index: 3),
            PageViewController.getInstance(index: 4),
            PageViewController.getInstance(index: 5),
        ]
        setViewControllers([individualPageViewControllerList[selecteIndex]], direction: .forward, animated: true, completion: nil)
    }
    
    // Update page when selected index chang
    fileprivate func updatePage(selecteIndex: Int, oldIndex: Int) {
        if selecteIndex > oldIndex {
            setViewControllers([individualPageViewControllerList[selecteIndex]], direction: .forward, animated: true, completion: nil)
        } else {
            setViewControllers([individualPageViewControllerList[selecteIndex]], direction: .reverse, animated: true, completion: nil)
        }
    }
}

// MARK: - Page view controller datasource
extension CustomPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let indexOfCurrentPageViewController = individualPageViewControllerList.firstIndex(of: viewController) else { return nil }
        if indexOfCurrentPageViewController == 0 {
            return nil
        } else {
            return individualPageViewControllerList[indexOfCurrentPageViewController - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let indexOfCurrentPageViewController = individualPageViewControllerList.firstIndex(of: viewController) else { return nil }
        if indexOfCurrentPageViewController == individualPageViewControllerList.count - 1 {
            return nil
        } else {
            return individualPageViewControllerList[indexOfCurrentPageViewController + 1]
        }
    }
}

// MARK: - Page view controller delegate
extension CustomPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController( _ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentIndexPageViewController = pageViewController.viewControllers?.first
            as? PageViewController {
            let index = individualPageViewControllerList.firstIndex(of: currentIndexPageViewController)!
            customDelegate?.CustomPageViewController(CustomPageViewController: self, didUpdatePageIndex: index)
        }
    }
}
