//
//  LinearCardAttributesAnimator2.swift
//  AnimatedCollectionViewLayout
//
//  Created by Max Lesichniy on 19.04.2022.
//

import UIKit

/// An animator that turns the cells into card mode.
/// - warning: You need to set `clipsToBounds` to `false` on the cell to make
/// this effective.
public struct LinearCardAttributesAnimatorV2 : LayoutAttributesAnimator {
    /// The alpha to apply on the cells that are away from the center. Should be
    /// in range [0, 1]. 0.5 by default.
    public var minAlpha: CGFloat
    
    /// The spacing ratio between two cells. 16.0 by default.
    public var itemSpacing: CGFloat
    
    /// The scale rate that will applied to the cells to make it into a card.
    public var scaleRate: CGFloat
    
    public init(minAlpha: CGFloat = 0.5, itemSpacing: CGFloat = 16.0, scaleRate: CGFloat = 0.7) {
        self.minAlpha = minAlpha
        self.itemSpacing = itemSpacing
        self.scaleRate = scaleRate
    }
    
    public func animate(collectionView: UICollectionView, attributes: AnimatedCollectionViewLayoutAttributes) {
        let position = attributes.middleOffset
        let scaleFactor = scaleRate - 0.1 * abs(position)
        let scaleTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)

        var translationTransform: CGAffineTransform = .identity
        
        if attributes.scrollDirection == .horizontal {
            let width = collectionView.frame.width
            let translationX = -(width * itemSpacing * position)
//            var translationX = -(attributes.size.width - (attributes.size.width * scaleFactor)) / 2
//            if position < 0 {
//                translationX *= position
//            }
//            translationTransform = CGAffineTransform(translationX: translationX, y: 0)
            attributes.center.x += translationX
        } else {
            let height = collectionView.frame.height
            let translationY = -(height * itemSpacing * position)
//            let translationY = -(attributes.size.height / 2 * (1 - scaleFactor)) * position
//            translationTransform = CGAffineTransform(translationX: 0, y: translationY)
            attributes.center.y += translationY
        }
        
//        attributes.anchorPoint.x = 1.0 - (0.5 + position)

//        let anchorPointOffsetValue = attributes.size.width
//        var anchorPointOffset = -(anchorPointOffsetValue * position)
//        attributes.center.x += anchorPointOffset
//        translationTransform = CGAffineTransform(translationX: anchorPointOffset, y: 0)
        
        let alpha = 1.0 - abs(position) + minAlpha
        attributes.alpha = alpha
        attributes.transform = translationTransform.concatenating(scaleTransform)
        attributes.zIndex = Int(alpha * 10)
    }
    
}
