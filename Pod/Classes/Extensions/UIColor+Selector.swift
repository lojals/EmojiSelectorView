//
//  UIColor+Selector.swift
//  EmojiSelectorView
//
//  Created by Jorge Ovalle on 31/10/20.
//

import Foundation

extension UIColor {
    
    public static var background: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.systemGray6
            } else {
                return UIColor.white
            }
        }
    }()
    
    public static var shadow: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.clear
            } else {
                return UIColor.lightGray
            }
        }
    }()
    
}
