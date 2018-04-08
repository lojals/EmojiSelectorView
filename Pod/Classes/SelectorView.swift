//
//  SelectorView.swift
//  JOEmojiableBtn
//
//  Created by Jorge Raul Ovalle Zuleta on 2/28/16.
//  Copyright © 2018 Jorge Ovalle. All rights reserved.
//

import UIKit

public protocol SelectorViewDelegate: class {
    func movedTo(_ point: CGPoint)
    func endTouch(_ point: CGPoint)
}

open class SelectorView: UIView {
    weak var delegate: SelectorViewDelegate?

    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = (touches.first?.location(in: self)) else { return }
        delegate?.movedTo(location)
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = (touches.first?.location(in: self)) else { return }
        delegate?.endTouch(location)
    }
}
