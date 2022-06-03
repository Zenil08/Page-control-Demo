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
    private var isPageChanged: Bool?
    private var selecteIndex: Int? {
        didSet {
            updatePage(from: oldValue ?? 0, to: selecteIndex ?? 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPageViewController()
    }
    
    private func setUpPageViewController() {
        dataSource = self
        delegate = self
        individualPageViewControllerList = getViewControllers()
        setViewControllers([individualPageViewControllerList[selecteIndex ?? 0]], direction: .forward, animated: true, completion: nil)
    }
    
    private func getViewControllers() -> [UIViewController]{
        var viewControllers: [UIViewController] = []
        for i in 0...(Tag.allCases.count - 1) {
            guard let pageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageViewController") as? PageViewController else { return viewControllers }
            let vc = pageVC
            vc.setIndex(to: i)
            viewControllers.append(vc)
        }
        return viewControllers
    }
    
    private func updatePage(from oldIndex: Int ,to selecteIndex: Int) {
        if isPageChanged ?? true {
            if selecteIndex > oldIndex {
                setViewControllers([individualPageViewControllerList[selecteIndex]], direction: .forward, animated: true, completion: nil)
            } else {
                setViewControllers([individualPageViewControllerList[selecteIndex]], direction: .reverse, animated: true, completion: nil)
            }
        }
    }
    
    func setSelectedIndex(to index: Int) {
        selecteIndex = index
    }
    
    func setIsPageChanged(to value: Bool) {
        isPageChanged = value
    }
}

// MARK: - Page view controller datasource
extension CustomPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
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
    
    func pageViewController( _ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentIndexPageViewController = pageViewController.viewControllers?.first else { return }
        if let index = individualPageViewControllerList.firstIndex(of: currentIndexPageViewController) {
            isPageChanged = finished
            setSelectedIndex(to: index)
            customDelegate?.CustomPageViewController(CustomPageViewController: self, didUpdatePageIndex: index)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let currentIndexPageViewController = pendingViewControllers.first {
            if let index = individualPageViewControllerList.firstIndex(of: currentIndexPageViewController) {
                isPageChanged = (selecteIndex == index)
                customDelegate?.CustomPageViewController(CustomPageViewController: self, didUpdatePageIndex: index)
            }
        }
    }
}
