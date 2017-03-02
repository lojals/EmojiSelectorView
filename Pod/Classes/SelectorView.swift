//
//  SelectorView.swift
//  JOEmojiableBtn
//
//  Created by Jorge Raul Ovalle Zuleta on 2/28/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit

public protocol SelectorViewDelegate{
    func movedTo(point:CGPoint)
    func endTouch(point:CGPoint)
}

public class SelectorView: UIView {
    var delegate:SelectorViewDelegate?
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.movedTo(point: (touches.first?.location(in: self))!)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.endTouch(point: (touches.first?.location(in: self))!)
    }
}
