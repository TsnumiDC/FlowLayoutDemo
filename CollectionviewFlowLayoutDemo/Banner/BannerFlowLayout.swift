//
//  BannerFlowLayout.swift
//  CollectionviewFlowLayoutDemo
//
//  Created by Dylan Chen on 2019/10/15.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

class BannerFlowLayout: UICollectionViewFlowLayout {
    
    open var minimumScale: CGFloat = 0.80
    open var maxScale: CGFloat = 0.90
    open var minimumAlpha: CGFloat = 0.6
    
    private var itemSpide: CGFloat = 0
    
    override func prepare() {
        let width = collectionView?.bounds.size.width ?? 0
        let height = collectionView?.bounds.size.height ?? 0
        let spacing = width * (1 - maxScale) / 2
        itemSpide = spacing
        let itemWidth = width * maxScale
        let itemHeight = height * maxScale
        minimumLineSpacing = spacing * 2
        sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        itemSize = CGSize(width: itemWidth, height: itemHeight)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        guard let origin = super.layoutAttributesForElements(in: rect) else {
            return nil
        }

        var new = origin.map({ $0 })
        let indexs = new.map { (attr) -> Int in
            return attr.indexPath.row
        }
        print("\(indexs)")
        for (index, attr) in origin.enumerated() {
            let attrNew = self.layoutAttributesForItem(at: attr.indexPath) ?? UICollectionViewLayoutAttributes()
            adjustTransform(attr: attrNew)
            new[index] = attrNew
//            print(attr.indexPath.row)
        }
//        if origin.count == 2 {
//            let index = origin[0].indexPath.row - 1
//            if index >= 0 {
//                let indexPath = IndexPath(row: index, section: 0)
//                let attr = self.layoutAttributesForItem(at: indexPath) ?? UICollectionViewLayoutAttributes()
//                new.insert(attr, at: 0)
//            }
//
//            let afterIndex = origin.last!.indexPath.row + 1
//            guard let collectionView = collectionView,
//                let dataSource = collectionView.dataSource else {
//                return new
//            }
//            let count = dataSource.collectionView(collectionView, numberOfItemsInSection: 0)
//            if afterIndex < count {
//                let indexPath = IndexPath(row: afterIndex, section: 0)
//                let attr = self.layoutAttributesForItem(at: indexPath) ?? UICollectionViewLayoutAttributes()
//                new.append(attr)
//            }
//        }
        return new
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        print(indexPath.row)
        return super.layoutAttributesForItem(at: indexPath)
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

extension BannerFlowLayout {
    private func adjustTransform(attr: UICollectionViewLayoutAttributes) {
        guard let collectionView = collectionView else {
            return
        }
        let width = collectionView.bounds.size.width
        //计算中心位置
        let spideToCenter = (attr.center.x - collectionView.bounds.midX)

        //计算距离中心的比例
        let position = spideToCenter / (width / 2.0)
        let realScale = 1 - (1-self.minimumScale) * abs(position)
        let scale = max(realScale, self.minimumScale)
        
        let adjSpide: CGFloat = itemSpide * (1 - realScale) * 5 * 1.8
//        print("\(attr.indexPath.row) position = \(position)  scale = \(scale) adjSpide = \(adjSpide)")
        var adjX: CGFloat = 0
        if position > 0 {
            adjX = attr.center.x - adjSpide
        } else if position < 0 {
            adjX = attr.center.x + adjSpide
        }
        attr.center = CGPoint(x: adjX, y: attr.center.y)

        let transform = CGAffineTransform(scaleX: scale, y: scale)
        attr.transform = transform
        attr.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
}
