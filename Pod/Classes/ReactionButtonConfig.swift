//
//  ReactionButtonConfig.swift
//  ReactionButton
//
//  Created by Jorge R Ovalle Z on 4/6/18.
//

import CoreGraphics

public extension ReactionButton {
    /// A type representing the basic configurations for a `ReactionButton`.
    struct Config {

        /// The space between options.
        let spacing: CGFloat

        /// The default size for an option.
        let size: CGFloat
        
        /// The size of an option before expand.
        let sizeBeforeOpen: CGFloat

        /// The minimum size when an option is being selected.
        let minSize: CGFloat

        /// The maximum size when the option is beign selected.
        let maxSize: CGFloat

        var heightForSize: CGFloat {
            size + 2 * spacing
        }

        /// Creates an instance of `JOReactionableConfig`
        ///
        /// - Parameters:
        ///   - spacing: The space between options.
        ///   - size: The default size for an option.
        ///   - minSize: The minimum size when an option is being selected.
        ///   - maxSize: The maximum size when the option is beign selected.
        ///   - spaceBetweenComponents: The space between the `SelectorView` and the `InformationView`.
        public init(spacing: CGFloat, size: CGFloat, minSize: CGFloat, maxSize: CGFloat) {
            self.spacing  = spacing
            self.size = size
            self.minSize = minSize
            self.maxSize = maxSize
            self.sizeBeforeOpen = 10
        }

        /// A `default` definition of `ReactionButton.Config`.
        public static let `default` = Config(spacing: 6,
                                             size: 40,
                                             minSize: 34,
                                             maxSize: 80)
    }

}
