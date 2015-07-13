//
//  SwiftBoxCollectionViewLayout.swift
//  SwiftBoxDemo
//
//  Created by James Tang on 12/7/15.
//  Copyright (c) 2015 Josh Abernathy. All rights reserved.
//

import UIKit
import SwiftBox

class SwiftBoxCollectionViewLayout : UICollectionViewLayout {

    var layout : Layout! {
        didSet {
            self.invalidateLayout()
        }
    }

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var attributes : [UICollectionViewLayoutAttributes] = self.layout.layoutAttributesForElementsInRect(rect)
        return attributes
    }

    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        return self.layout.layoutAttributesForItemAtIndexPath(indexPath)
    }

    override func collectionViewContentSize() -> CGSize {
        return self.layout.frame.size
    }

}
