//
//  TextNode.swift
//  SwiftBoxDemo
//
//  Created by James Tang on 13/7/15.
//  Copyright (c) 2015 Josh Abernathy. All rights reserved.
//

import UIKit
import SwiftBox

public struct TextNode {

    public let text : String
    public let font : UIFont
    public let margin : Edges
    public let padding : Edges

    public func node() -> Node {
        let label : UILabel = UILabel()
        label.numberOfLines = 0
        return Node(margin: self.margin, padding: self.padding, measure: { w in
            label.preferredMaxLayoutWidth = w
            label.text = self.text
            return label.sizeThatFits(CGSizeMake(w, CGFloat.max))
        })
    }

    public init(text: String, font: UIFont, margin: Edges = Edges(uniform: 0), padding : Edges = Edges(uniform: 0)) {
        self.text = text
        self.font = font
        self.margin = margin
        self.padding = padding
    }

}