//
//  PageViewController.swift
//  Page control Demo
//
//  Created by MAC241 on 17/05/22.
//

import UIKit

class PageViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    var index = 0
    let colors = [
        UIColor.red,
        .green,
        .blue,
        .systemPink,
        .purple,
        .brown
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
        lblTitle.text = "(Page \(index))"
        view.backgroundColor = colors[index]
    }
}
