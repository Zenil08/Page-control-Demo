//
//  CollectionViewCell.swift
//  Page control Demo
//
//  Created by MAC241 on 17/05/22.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var lblTagName: UILabel!
    @IBOutlet private weak var tagBackgroundView: UIView!
    
    override var isSelected: Bool {
        didSet {
            tagBackgroundView.backgroundColor = isSelected ? .black : .lightGray
            lblTagName.textColor = isSelected ? .white : .black
        }
    }
    static let identifier = "TagCollectionViewCell"
    var tagName: String? {
        didSet {
            lblTagName.text = tagName
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        tagBackgroundView.layer.cornerRadius = tagBackgroundView.frame.height / 2
        layer.masksToBounds = true
    }
}
