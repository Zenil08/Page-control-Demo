//
//  CollectionViewCell.swift
//  Page control Demo
//
//  Created by MAC241 on 17/05/22.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TagCollectionViewCell"
    
    @IBOutlet weak var lblTagName: UILabel!
    @IBOutlet private weak var tagBackgroundView: UIView!
    
    override var isSelected: Bool {
        didSet {
            tagBackgroundView.backgroundColor = isSelected ? UIColor.black : UIColor.lightGray
            lblTagName.textColor = isSelected ? .white : .black
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        tagBackgroundView.layer.cornerRadius = tagBackgroundView.frame.height / 2
        layer.masksToBounds = true
    }
}
