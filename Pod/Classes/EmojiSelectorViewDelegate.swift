//
//  EmojiSelectorViewDelegate.swift
//  EmojiSelectorView
//
//  Created by Jorge R Ovalle Z on 4/11/18.
//

import Foundation

/// Describes a type that is informed of events occurring within a `EmojiSelectorView`.
public protocol EmojiSelectorViewDelegate: class {

    /// The user selected an option from the sender.
    ///
    /// - Parameters:
    ///   - sender: The `EmojiSelectorView` which is sending the action.
    ///   - index: Index of the selected option.
    func selectedOption(_ sender: EmojiSelectorView, index: Int)

    /// The user cancelled the option selection.
    ///
    /// - Parameter sender: The `EmojiSelectorView` which is sending the action.
    func cancelledAction(_ sender: EmojiSelectorView)
}
