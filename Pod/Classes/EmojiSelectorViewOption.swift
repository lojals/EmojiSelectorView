//
//  JOEmojiableOption.swift
//  EmojiSelectorView
//
//  Created by Jorge R Ovalle Z on 4/6/18.
//

import UIKit

/// A type that represents the option of a selector.
public class EmojiSelectorViewOption {

    /// The image will be used for the option represented.
    /// (This image should be added to the bundle).
    let image: UIImage

    /// The name of the option represented.
    let name: String
    
    /// Whether use or not a systemName (SF Symbols)
    let nameType: ImageType

    /// Creates an instance of `JOEmojiableOption`.
    ///
    /// - Parameters:
    ///   - image: The image will be used for the option represented.
    ///     (This image should be added to the bundle).
    ///   - name: The name of the option represented.
    public init(image: UIImage, name: String, nameType: ImageType = .name) {
        self.image = image
        self.name  = name
        self.nameType = nameType
    }
    
    public enum ImageType {
        case name
        case systemName
    }
}
