//
//  ViewController.swift
//  Page control Demo
//
//  Created by MAC241 on 17/05/22.
//

import UIKit

class TagViewController: UIViewController {
    
    @IBOutlet private weak var tagCollectionView: UICollectionView!
    private var customPageViewController: CustomPageViewController? {
        didSet {
            customPageViewController?.customDelegate = self
        }
    }
    private var currentIndex = 0
    private let tag = ["Following", "For You", "Popular", "Genre", "Trending", "Recently"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagCollectionView.register(UINib(nibName: TagCollectionViewCell.cellNibName, bundle: nil), forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CustomPageViewController {
            customPageViewController = vc
        }
    }
}

// MARK: - tag collection view delegate and datasource
extension TagViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
        if indexPath.row == currentIndex {
            cell.isCellSelected = true
        } else {
            cell.isCellSelected = false
        }
        cell.lblTagName.text = tag[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TagCollectionViewCell {
            cell.isCellSelected = true
        }
        customPageViewController?.selecteIndex = indexPath.row
        currentIndex = indexPath.row
        collectionView.reloadData()
    }
}

// MARK: - Page view controller custom delegate
extension TagViewController: CustomPageViewControllerDelegate {
    
    func CustomPageViewController(CustomPageViewController: CustomPageViewController, didUpdatePageIndex index: Int) {
        currentIndex = index
        DispatchQueue.main.async { [weak self] in
            self?.tagCollectionView.reloadData()
        }
    }
}

