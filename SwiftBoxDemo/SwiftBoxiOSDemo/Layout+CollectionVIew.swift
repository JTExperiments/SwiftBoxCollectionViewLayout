//
//  Layout+CollectionVIew.swift
//  SwiftBoxDemo
//
//  Created by James Tang on 12/7/15.
//  Copyright (c) 2015 Josh Abernathy. All rights reserved.
//

import Foundation
import SwiftBox
import UIKit

extension Layout {

    func layoutsInRect(rect: CGRect) -> [Layout] {
        return self.children.filter { CGRectIntersectsRect(rect, $0.frame) }
    }

    func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes] {
        let layouts = self.layoutsInRect(rect)
        var attributes : [UICollectionViewLayoutAttributes] = []
        for (_, layout) in enumerate(layouts) {
            let index = find(self.children, layout)!
            let indexPath = NSIndexPath(forItem: index, inSection: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            attribute.applyLayout(layout)
            attributes.append(attribute)
        }
        return attributes
    }

    func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes {
        let attribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        let layout = self.children[indexPath.row]
        attribute.applyLayout(layout)
        return attribute
    }

}

extension UICollectionViewLayoutAttributes {
    func applyLayout(layout: Layout) {
        self.frame = layout.frame
    }
}


extension Layout : Equatable {

}

public func == (lhs: Layout, rhs: Layout) -> Bool {
    if lhs.frame == rhs.frame && lhs.children == rhs.children {
        return true
    }
    return false
}