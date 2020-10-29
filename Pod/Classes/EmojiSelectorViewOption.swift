//
//  JOEmojiableOption.swift
//  EmojiSelectorView
//
//  Created by Jorge R Ovalle Z on 4/6/18.
//

import Foundation

/// A type that represents the option of a selector.
public struct EmojiSelectorViewOption {

    /// The image will be used for the option represented.
    /// (This image should be added to the bundle).
    let image: String

    /// The name of the option represented.
    let name: String

    /// Creates an instance of `JOEmojiableOption`.
    ///
    /// - Parameters:
    ///   - image: The image will be used for the option represented.
    ///     (This image should be added to the bundle).
    ///   - name: The name of the option represented.
    public init(image: String, name: String) {
        self.image = image
        self.name  = name
    }
}
