//
//  ViewController.swift
//  Page control Demo
//
//  Created by MAC241 on 17/05/22.
//

import UIKit

class TagViewController: UIViewController {

    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    private let tag = ["Following", "For You", "Popular", "Genre", "Trending", "Recently"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagCollectionView.register(UINib(nibName: TagCollectionViewCell.cellNibName, bundle: nil), forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
    }
}

// MARK: - tag collection view delegate and datasource
extension TagViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell
        cell?.lblTagName.text = tag[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

