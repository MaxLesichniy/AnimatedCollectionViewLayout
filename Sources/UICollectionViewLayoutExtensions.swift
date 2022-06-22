//
//  UICollectionViewLayoutExtensions.swift
//  AnimatedCollectionViewLayout
//
//  Created by Max Lesichniy on 04.04.2022.
//

import UIKit

extension UICollectionViewLayout {
    
    func transformLayoutAttributes(_ attributes: AnimatedCollectionViewLayoutAttributes,
                                   scrollDirection: UICollectionView.ScrollDirection,
                                   with animator: LayoutAttributesAnimator?) -> UICollectionViewLayoutAttributes {
        
        guard let collectionView = self.collectionView else { return attributes }
        
        let a = attributes
        
        /**
         The position for each cell is defined as the ratio of the distance between
         the center of the cell and the center of the collectionView and the collectionView width/height
         depending on the scroll direction. It can be negative if the cell is, for instance,
         on the left of the screen if you're scrolling horizontally.
         */
        
        let distance: CGFloat
        let itemOffset: CGFloat
        
        if scrollDirection == .horizontal {
            distance = collectionView.frame.width
            itemOffset = a.center.x - collectionView.contentOffset.x
            a.startOffset = (a.frame.origin.x - collectionView.contentOffset.x) / a.frame.width
            a.endOffset = (a.frame.origin.x - collectionView.contentOffset.x - collectionView.frame.width) / a.frame.width
        } else {
            distance = collectionView.frame.height
            itemOffset = a.center.y - collectionView.contentOffset.y
            a.startOffset = (a.frame.origin.y - collectionView.contentOffset.y) / a.frame.height
            a.endOffset = (a.frame.origin.y - collectionView.contentOffset.y - collectionView.frame.height) / a.frame.height
        }
        
        a.scrollDirection = scrollDirection
        a.middleOffset = itemOffset / distance - 0.5
        
        // Cache the contentView since we're going to use it a lot.
        if a.contentView == nil,
            let c = collectionView.cellForItem(at: attributes.indexPath)?.contentView {
            a.contentView = c
        }
        
        animator?.animate(collectionView: collectionView, attributes: a)
        
        return a
    }
    
    
}
