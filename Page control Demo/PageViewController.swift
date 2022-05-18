//
//  PageViewController.swift
//  Page control Demo
//
//  Created by MAC241 on 17/05/22.
//

import UIKit

class PageViewController: UIViewController {
    
    @IBOutlet private weak var lblTitle: UILabel!
    private var index = 0
    private let colors = [
        UIColor.brown,
        .green,
        .blue,
        .systemPink,
        .purple,
        .systemRed
    ]
    
    static func getInstance(index: Int) -> PageViewController {
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PageViewController") as! PageViewController
            vc.index = index
            return vc
        } else {
            return PageViewController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = "(Page \(index + 1))"
        view.backgroundColor = colors[index]
    }
}
