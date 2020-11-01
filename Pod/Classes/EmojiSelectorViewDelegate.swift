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
    func emojiSelector(_ sender: EmojiSelectorView, didSelectedIndex index: Int)

    /// The user is moving through the options.
    /// - Parameters:
    ///   - sender: The `EmojiSelectorView` which is sending the action.
    ///   - index: Index of the selected option.
    func emojiSelector(_ sender: EmojiSelectorView, didChangeFocusTo index: Int?)
    
    /// The user cancelled the option selection.
    ///
    /// - Parameter sender: The `EmojiSelectorView` which is sending the action.
    func emojiSelectorDidCancelledAction(_ sender: EmojiSelectorView)
    
}

public protocol EmojiSelectorViewDelegateLayout: EmojiSelectorViewDelegate {
    func emojiSelectorConfiguration(_ selector: EmojiSelectorView) -> EmojiSelectorView.Config
}

public extension EmojiSelectorViewDelegateLayout {
    func emojiSelectorConfiguration(_ selector: EmojiSelectorView) -> EmojiSelectorView.Config {
        .default
    }
}

/// Default implementation for delegate
public extension EmojiSelectorViewDelegate {
    func emojiSelector(_ sender: EmojiSelectorView, didSelectedIndex index: Int) {}
    func emojiSelector(_ sender: EmojiSelectorView, didChangeFocusTo index: Int?) {}
    func emojiSelectorDidCancelledAction(_ sender: EmojiSelectorView) {}
}

public protocol EmojiSelectorViewDataSource: class {
    
    /// Asks the data source to return the number of items in the EmojiSelectorView.
    func numberOfOptions(in selector: EmojiSelectorView) -> Int

    /// Asks the data source for the view of the specific item.
    func emojiSelector(_ selector: EmojiSelectorView, viewForIndex index: Int) -> UIView
    
    /// Asks the data source for the name of the specific item.
    func emojiSelector(_ selector: EmojiSelectorView, nameForIndex index: Int) -> String
}
