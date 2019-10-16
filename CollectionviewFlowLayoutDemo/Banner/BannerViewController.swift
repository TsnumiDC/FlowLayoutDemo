//
//  BannerViewController.swift
//  CollectionviewFlowLayoutDemo
//
//  Created by Dylan Chen on 2019/10/15.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

class BannerViewController: UIViewController {

    static let cellIdentifity = "BannerViewControllerUICollectionViewCell"
    private var collectionView: UICollectionView = {
        let flowLayout = BannerFlowLayout()
        flowLayout.scrollDirection = .horizontal
//        flowLayout.minimumInteritemSpacing = 30
//        flowLayout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.yellow
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: BannerViewController.cellIdentifity)
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        var frame = view.bounds
        frame.origin.y = 100
        frame.size.height = 250
        collectionView.frame = frame
        
        view.backgroundColor = UIColor.white
        
    }

}

extension BannerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerViewController.cellIdentifity, for: indexPath)
        let color = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        cell.backgroundColor = color
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print("didEndDisplaying \(indexPath.row)")
//    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("willDisplay \(indexPath.row)")
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.bounds.size.width, height:collectionView.bounds.size.height )
//    }
    
}

extension BannerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
    }
}
