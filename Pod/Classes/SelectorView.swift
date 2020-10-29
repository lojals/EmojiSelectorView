//
//  SelectorView.swift
//  EmojiSelectorView
//
//  Created by Jorge Raul Ovalle Zuleta on 2/28/16.
//

import UIKit

/// Describes a type that is informed of events occurring within a `SelectorView`.
public protocol SelectorViewDelegate: AnyObject {

    /// This function is dispatched when `touchesMoved` is triggered in `SelectorView`.
    ///
    /// - Parameter point: CGPoint where the finger moved.
    func movedTo(_ point: CGPoint)

    /// This function is dispatched when `touchesEnded` is triggered in `SelectorView`.
    ///
    /// - Parameter point: CGPoint where the finger move ended.
    func endTouch(_ point: CGPoint)
}

/// A type that represents the SelectorView where options are shown.
open class SelectorView: UIView {

    /// The object that acts as the delegate of the `SelectorView`.
    weak var delegate: SelectorViewDelegate?

    /// Sent to the gesture recognizer when one or more fingers move in the associated view.
    ///
    /// - Parameters:
    ///   - touches: A set of UITouch instances in the event represented by
    ///     event that represent touches in the UITouchPhaseMoved phase.
    ///   - event: A UIEvent object representing the event to which the touches belong.
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = (touches.first?.location(in: self)) else { return }
        delegate?.movedTo(location)
    }

    /// Sent to the gesture recognizer when one or more fingers lift from the associated view.
    ///
    /// - Parameters:
    ///   - touches: A set of UITouch instances in the event represented by event that represent
    ///     the touches in the UITouchPhaseEnded phase.
    ///   - event: A UIEvent object representing the event to which the touches belong.
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = (touches.first?.location(in: self)) else { return }
        delegate?.endTouch(location)
    }
}
