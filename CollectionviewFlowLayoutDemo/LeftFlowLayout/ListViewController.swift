//
//  ListViewController.swift
//  CollectionviewFlowLayoutDemo
//
//  Created by Dylan Chen on 2019/10/15.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    static let cellIdentifity = "UICollectionViewCell"
    private var collectionView: UICollectionView = {
        let flowLayout = LeftAliginLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: ListViewController.cellIdentifity)
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = view.bounds
    }
}

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListViewController.cellIdentifity, for: indexPath)
        cell.backgroundColor = UIColor.red
        cell.largeContentTitle = "\(indexPath)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Double.random(in: 50...90), height:100 )
    }
    
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    
}
