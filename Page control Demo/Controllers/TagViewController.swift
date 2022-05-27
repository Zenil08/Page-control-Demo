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
    private var currentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagCollectionView.register(UINib(nibName: TagCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.delegate?.collectionView?(tagCollectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
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
        Tag.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
        if indexPath.row == currentIndex {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            customPageViewController?.setSelectedIndex(to: indexPath.row)
        }
        cell.lblTagName.text = Tag.allCases[indexPath.row].rawValue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        customPageViewController?.setSelectedIndex(to: indexPath.row)
        collectionView.reloadData()
    }
}

// MARK: - Tag Collection View Delegate FlowLayout
extension TagViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = Tag.allCases[indexPath.row].rawValue
        label.sizeToFit()
        let height = label.frame.height
        let collWidth = (collectionView.bounds.width - 50) / 4.2
        let collHeight = height + 8
        return CGSize(width: collWidth, height: collHeight)
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

