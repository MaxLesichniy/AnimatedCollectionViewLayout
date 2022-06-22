//
//  AnimatedCollectionViewLayout.swift
//  AnimatedCollectionViewLayout
//
//  Created by Jin Wang on Feb 8, 2017.
//  Copyright © 2017 Uthoft. All rights reserved.
//

import Foundation
import UIKit

/// A `UICollectionViewFlowLayout` subclass enables custom transitions between cells.
open class AnimatedCollectionViewLayout: UICollectionViewFlowLayout {
    
    /// The animator that would actually handle the transitions.
    open var animator: LayoutAttributesAnimator?
    
    /// Overrided so that we can store extra information in the layout attributes.
    open override class var layoutAttributesClass: AnyClass { return AnimatedCollectionViewLayoutAttributes.self }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        return attributes.compactMap { $0.copy() as? AnimatedCollectionViewLayoutAttributes }.map {
            self.transformLayoutAttributes($0, scrollDirection: scrollDirection, with: animator)
        }
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? AnimatedCollectionViewLayoutAttributes else { return nil }
        return self.transformLayoutAttributes(attributes, scrollDirection: scrollDirection, with: animator)
    }
    
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // We have to return true here so that the layout attributes would be recalculated
        // everytime we scroll the collection view.
        return true
    }

}
