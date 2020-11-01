//
//  UIView+contains.swift
//  ReactionButton
//
//  Created by Jorge Ovalle on 29/10/20.
//

import UIKit

extension UIView {
    
    /// A function that checks if a given point is whether or not in the frame of the view.
    /// - Parameter point: The point to look for.
    /// - Returns: A boolean that represents if the point is inside the frame.
    func contains(_ point: CGPoint) -> Bool {
        point.x > frame.minX && point.x < frame.maxX && point.y > frame.minY && point.y < frame.maxY
    }
    
}
