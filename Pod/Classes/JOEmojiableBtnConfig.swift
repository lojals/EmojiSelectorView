//
//  JOEmojiableBtnConfig.swift
//  JOEmojiableBtn
//
//  Created by Jorge R Ovalle Z on 4/6/18.
//

import CoreGraphics

/// A type representing the basic configurations for a `JOEmojiableBtn`.
public struct JOEmojiableConfig {

    /// The space between options.
    let spacing: CGFloat

    /// The default size for an option.
    let size: CGFloat

    /// The minimum size when an option is being selected.
    let minSize: CGFloat

    /// The maximum size when the option is beign selected.
    let maxSize: CGFloat

    /// The space between the `SelectorView` and the `InformationView`.
    let spaceBetweenComponents: CGFloat

    var heightForMinSize: CGFloat {
        return minSize + 2 * spacing
    }

    var heightForSize: CGFloat {
        return size + 2 * spacing
    }

    /// Creates an instance of `JOEmojiableConfig`
    ///
    /// - Parameters:
    ///   - spacing: The space between options.
    ///   - size: The default size for an option.
    ///   - minSize: The minimum size when an option is being selected.
    ///   - maxSize: The maximum size when the option is beign selected.
    ///   - spaceBetweenComponents: The space between the `SelectorView` and the `InformationView`.
    public init(spacing: CGFloat, size: CGFloat, minSize: CGFloat, maxSize: CGFloat, spaceBetweenComponents: CGFloat) {
        self.spacing  = spacing
        self.size = size
        self.minSize = minSize
        self.maxSize = maxSize
        self.spaceBetweenComponents = spaceBetweenComponents
    }	

    /// A `default` definition of `JOEmojiableConfig`.
    public static let `default` = JOEmojiableConfig(spacing: 6,
                                                    size: 40,
                                                    minSize: 34,
                                                    maxSize: 80,
                                                    spaceBetweenComponents: 30)
}
