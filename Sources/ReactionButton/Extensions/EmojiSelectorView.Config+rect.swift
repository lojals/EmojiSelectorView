//
//  ReactionButton.Config+rect.swift
//  ReactionButton
//
//  Created by Jorge Ovalle on 30/10/20.
//

import UIKit

extension ReactionButton.Config {
    
    func rect(items: Int, originalPos: CGPoint, trait: UITraitCollection) -> CGRect {
        var originalPos = CGPoint(x: originalPos.x, y: originalPos.y - heightForSize - 10)
        let option = CGFloat(items)
        let width = (option + 1) * spacing + self.size * option
        
        if trait.horizontalSizeClass == .compact && trait.verticalSizeClass == .regular {
            originalPos.x = (UIScreen.main.bounds.width - width) / 2
        }
        
        return CGRect(origin: originalPos, size: CGSize(width: width, height: heightForSize))
    }
    
}
