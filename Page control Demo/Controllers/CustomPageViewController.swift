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
    private var selecteIndex = 0 {
        didSet {
            updatePage(from: oldValue, to: selecteIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPageViewController()
    }
    
    fileprivate func setUpPageViewController() {
        dataSource = self
        delegate = self
        individualPageViewControllerList = getViewControllers()
        setViewControllers([individualPageViewControllerList[selecteIndex]], direction: .forward, animated: true, completion: nil)
    }
    
    fileprivate func getViewControllers() -> [UIViewController]{
        var viewControllers: [UIViewController] = []
        for i in 0...(Tag.allCases.count - 1) {
            let pageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
            let vc = pageVC
            vc.index = i
            viewControllers.append(vc)
        }
        return viewControllers
    }
    
    // Update page when selected index change
    fileprivate func updatePage(from oldIndex: Int ,to selecteIndex: Int) {
        if selecteIndex > oldIndex {
            setViewControllers([individualPageViewControllerList[selecteIndex]], direction: .forward, animated: true, completion: nil)
        } else {
            setViewControllers([individualPageViewControllerList[selecteIndex]], direction: .reverse, animated: true, completion: nil)
        }
    }
    
    func setSelectedIndex(to: Int) {
        selecteIndex = to
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
           if let index = individualPageViewControllerList.firstIndex(of: currentIndexPageViewController) {
               selecteIndex = index
               customDelegate?.CustomPageViewController(CustomPageViewController: self, didUpdatePageIndex: index)
           }
        }
    }
}
