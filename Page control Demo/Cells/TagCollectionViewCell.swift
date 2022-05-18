//
//  CollectionViewCell.swift
//  Page control Demo
//
//  Created by MAC241 on 17/05/22.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTagName: UILabel!
    var isCellSelected: Bool = false {
        didSet {
            layer.backgroundColor = isCellSelected ? UIColor.black.cgColor : UIColor.lightGray.cgColor
            lblTagName.textColor = isCellSelected ? .white : .black
        }
    }
    
    static let identifier = "TagCollectionViewCell"
    static let cellNibName = "TagCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = lblTagName.frame.size.height / 2
        layer.masksToBounds = true
    }
}
