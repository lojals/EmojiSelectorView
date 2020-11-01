//
//  CGSize+init.swift
//  ReactionButton
//
//  Created by Jorge R Ovalle Z on 4/7/18.
//

import CoreGraphics

extension CGSize {

    /// Creates an instance of `CGSize` with the same width and height.
    ///
    /// - Parameter sideSize: Size of the side.
    init(sideSize: CGFloat) {
        self.init(width: sideSize, height: sideSize)
    }
}
