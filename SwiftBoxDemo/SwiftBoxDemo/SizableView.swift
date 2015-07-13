//
//  SizableView.swift
//  SwiftBoxDemo
//
//  Created by James Tang on 9/7/15.
//  Copyright (c) 2015 Josh Abernathy. All rights reserved.
//

import Cocoa
import SwiftBox

class SizableView: NSView {

    var layout : Layout?

    override var flipped : Bool {
        return true
    }
}
