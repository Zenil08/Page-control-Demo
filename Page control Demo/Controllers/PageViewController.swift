//
//  PageViewController.swift
//  Page control Demo
//
//  Created by MAC241 on 17/05/22.
//

import UIKit

class PageViewController: UIViewController {
    
    @IBOutlet private weak var lblTitle: UILabel!
    var index = 0
    private let colors = [
        UIColor.brown,
        .green,
        .blue,
        .systemPink,
        .purple,
        .systemRed
    ]
     
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = "Page \(index + 1)"
        view.backgroundColor = colors[index]
    }
}
