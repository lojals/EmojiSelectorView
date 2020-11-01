//
//  ReactionButton+protocols.swift
//  ReactionButton
//
//  Created by Jorge R Ovalle Z on 4/11/18.
//

import UIKit

/// Describes a type that is informed of events occurring within a `ReactionButton`.
public protocol ReactionButtonDelegate: class {

    /// The user selected an option from the sender.
    ///
    /// - Parameters:
    ///   - sender: The `ReactionButton` which is sending the action.
    ///   - index: Index of the selected option.
    func ReactionSelector(_ sender: ReactionButton, didSelectedIndex index: Int)

    /// The user is moving through the options.
    /// - Parameters:
    ///   - sender: The `ReactionButton` which is sending the action.
    ///   - index: Index of the selected option.
    func ReactionSelector(_ sender: ReactionButton, didChangeFocusTo index: Int?)
    
    /// The user cancelled the option selection.
    ///
    /// - Parameter sender: The `ReactionButton` which is sending the action.
    func ReactionSelectorDidCancelledAction(_ sender: ReactionButton)
    
}

public protocol ReactionButtonDelegateLayout: ReactionButtonDelegate {
    func ReactionSelectorConfiguration(_ selector: ReactionButton) -> ReactionButton.Config
}

public extension ReactionButtonDelegateLayout {
    func ReactionSelectorConfiguration(_ selector: ReactionButton) -> ReactionButton.Config {
        .default
    }
}

/// Default implementation for delegate
public extension ReactionButtonDelegate {
    func ReactionSelector(_ sender: ReactionButton, didSelectedIndex index: Int) {}
    func ReactionSelector(_ sender: ReactionButton, didChangeFocusTo index: Int?) {}
    func ReactionSelectorDidCancelledAction(_ sender: ReactionButton) {}
}

public protocol ReactionButtonDataSource: class {
    
    /// Asks the data source to return the number of items in the ReactionButton.
    func numberOfOptions(in selector: ReactionButton) -> Int

    /// Asks the data source for the view of the specific item.
    func ReactionSelector(_ selector: ReactionButton, viewForIndex index: Int) -> UIView
    
    /// Asks the data source for the name of the specific item.
    func ReactionSelector(_ selector: ReactionButton, nameForIndex index: Int) -> String
}
