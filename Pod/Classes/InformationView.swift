//
//  InformationView.swift
//  EmojiSelectorView
//
//  Created by Jorge R Ovalle Z on 4/6/18.
//

import UIKit

/// A type that represents an `InformationView`.
class InformationView: UIView {

    /// Constants for UI purposes.
    private enum DesignConstants {

        /// The width for the border lines.
        static let borderLinesWidth: CGFloat = 1

        /// The color for the top and button borders in the current `InformationView`.
        static let lineColor = UIColor(red: 0.8, green: 0.81, blue: 0.82, alpha: 1)

        /// The color of the information we're displaying.
        static let textColor = UIColor(red: 0.57, green: 0.59, blue: 0.64, alpha: 1)

        /// The width for the dotted line when when the user is selecting an option.
        static let dotSize: CGFloat = 3

        /// The spacing between dots.
        static let dotSpacing: CGFloat = 37
    }

    /// The `UILabel` where information is displayed.
    private lazy var textInformation: UILabel = {
        let textInformation = UILabel(frame: .zero)
        textInformation.backgroundColor = .white
        textInformation.textColor = DesignConstants.textColor
        textInformation.text = "Release to Cancel"
        textInformation.textAlignment = .center
        textInformation.font = UIFont.boldSystemFont(ofSize: 12)
        textInformation.isHidden = true
        return textInformation
    }()

    open override func draw(_ rect: CGRect) {

        func createLine(from: CGPoint, to: CGPoint) {
            let line = UIBezierPath()
            line.move(to: from)
            line.addLine(to: to)
            DesignConstants.lineColor.setStroke()
            line.lineWidth = DesignConstants.borderLinesWidth
            line.stroke()
        }

        let dots = UIBezierPath()
        dots.move(to: CGPoint(x: DesignConstants.dotSpacing/2, y: (rect.height / 2)))
        dots.addLine(to: CGPoint(x: rect.width, y: (rect.height/2)))
        dots.lineCapStyle = .round
        DesignConstants.lineColor.setStroke()
        dots.lineWidth = DesignConstants.dotSize
        let dashes: [CGFloat] = [0, DesignConstants.dotSpacing]
        dots.setLineDash(dashes, count: dashes.count, phase: 0)
        dots.stroke()

        textInformation.frame = CGRect(origin: CGPoint(x: 0, y: DesignConstants.borderLinesWidth),
                                       size: CGSize(width: rect.width, height: rect.height - (DesignConstants.borderLinesWidth * 2)))
        addSubview(textInformation)

        createLine(from: .zero, to: CGPoint(x: rect.width, y: 0))
        createLine(from: CGPoint(x: 0, y: rect.height), to: CGPoint(x: rect.width, y: rect.height))

    }

    /// Show the current `InformationView`.
    func show() {
        textInformation.isHidden = false
        alpha = 1
    }

    /// Hide the current `InformationView`.
    func hide() {
        textInformation.isHidden = true
    }
}
