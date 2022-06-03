//
//  ViewController.swift
//  Page control Demo
//
//  Created by MAC241 on 17/05/22.
//

import UIKit

class TagViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tagCollectionView: UICollectionView!
    
    private var customPageViewController: CustomPageViewController? {
        didSet {
            customPageViewController?.customDelegate = self
        }
    }
    private var currentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTagCollectionView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let customPageVC = segue.destination as? CustomPageViewController {
            customPageViewController = customPageVC
        }
    }
    
    private func setUpTagCollectionView() {
        tagCollectionView.register(UINib(nibName: TagCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
}

// MARK: - tag collection view delegate and datasource
extension TagViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Tag.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
        if indexPath.row == currentIndex {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            customPageViewController?.setSelectedIndex(to: indexPath.row)
        }
        cell.tagName = Tag.allCases[indexPath.row].rawValue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        customPageViewController?.setIsPageChanged(to: true)
        customPageViewController?.setSelectedIndex(to: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let cellSpacing = flowLayout.minimumInteritemSpacing * 4
        let sectionInset = flowLayout.sectionInset
        let label = UILabel(frame: CGRect.zero)
        label.text = Tag.allCases[indexPath.row].rawValue
        label.sizeToFit()
        let collWidth = (collectionView.bounds.width - sectionInset.left - sectionInset.right - cellSpacing) / 4
        let collHeight = label.frame.height + sectionInset.top + sectionInset.bottom
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

