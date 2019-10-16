//
//  LeftAliginLayout.swift
//  CollectionviewFlowLayoutDemo
//
//  Created by Dylan Chen on 2019/10/15.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

class LeftAliginLayout: UICollectionViewFlowLayout {
        
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let origin = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        var new = origin.map({ $0 })
        for (index, ele) in origin.enumerated() {
            if (ele.representedElementKind == nil) {
                new[index] = self.layoutAttributesForItem(at: ele.indexPath) ?? UICollectionViewLayoutAttributes()
            }
        }
        return new
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let currentFrameAttr = super.layoutAttributesForItem(at: indexPath)
        
        if indexPath.item == 0 {
            return currentFrameAttr
        }
        
        let layoutWidth = collectionView?.frame.size.width ?? 0
        let preFrame = self.layoutAttributesForItem(at: IndexPath(item: indexPath.item - 1, section: indexPath.section))?.frame ?? .zero
        let currentFrame = currentFrameAttr?.frame ?? .zero
        let preRight = preFrame.origin.x + preFrame.size.width
        var curX = preRight + minimumInteritemSpacing
        if curX + currentFrame.size.width > layoutWidth {
            curX = 0
        }
        let adjustFrame = CGRect(x: curX,
                                 y: currentFrame.origin.y,
                                 width: currentFrame.size.width,
                                 height: currentFrame.size.height)
        currentFrameAttr?.frame = adjustFrame
        return currentFrameAttr
    }
    
}
