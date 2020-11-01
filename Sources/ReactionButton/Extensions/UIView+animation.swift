//
//  UIView+animation.swift
//  ReactionButton
//
//  Created by Jorge Ovalle on 29/10/20.
//

import UIKit

extension UIView {
    static func animate(index: Int, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, delay: 0.05 * Double(index), options: .curveEaseInOut) {
            animations()
        } completion: { finished in
            completion?(finished)
        }
    }
}
