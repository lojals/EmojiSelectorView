//
//  EmojiSelectorView.swift
//  EmojiSelectorView
//
//  Created by Jorge Raul Ovalle Zuleta on 2/28/16.
//

import UIKit

/// A type that represents the selector with options froma dataset.
open class EmojiSelectorView: UIButton {

    /// Constants used for UI component layout.
    private enum DesignConstants {

        /// The bottom threshold area to release / cancel the selection.
        static let bottomThresholdLoseFocus: CGFloat = 50

        /// The top threshold area to release / cancel the selection.
        static let topThresholdLoseFocus: CGFloat = 30

        /// A `CGRect` that match with the screen rect.
        static let screenRect = UIScreen.main.bounds

        /// The size of the option when the expande animation start.
        static let sizeBeforeOpen: CGFloat = 10
    }

    // MARK: - Properties declaration

    open weak var delegate: EmojiSelectorViewDelegate?

    open var dataset: [EmojiSelectorViewOption] = []

    private var isActive: Bool = false
    public private (set) var selectedItem: Int?
    private var originPoint: CGPoint = .zero

    private lazy var backgroundView: UIView = {
        let backgroundView = UIView(frame: DesignConstants.screenRect)
        backgroundView.backgroundColor = .clear
        return backgroundView
    }()

    private var optionsView: UIView!

    private let config: EmojiSelectorView.Config

    // MARK: - Events declaration

    private lazy var longTap: UILongPressGestureRecognizer = {
        return UILongPressGestureRecognizer(target: self,
                                            action: #selector(EmojiSelectorView.expand))
    }()

    // MARK: - View lifecycle

    /// Creates a new instace of `EmojiSelectorView`.
    ///
    /// - Parameters:
    ///   - frame: Frame of the button will open the selector
    ///   - config: The custom configuration for the UI components.
    public init(frame: CGRect, config: EmojiSelectorView.Config = .default) {
        self.config = config
        self.dataset = []
        super.init(frame: frame)

        addGestureRecognizer(longTap)
        layer.masksToBounds = false
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Visual component interaction / animation

    /// Function that open and expand the Options Selector.
    @objc private func expand(sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
            collapse()
            return
        }
        
        let point = sender.location(ofTouch: 0, in: UIApplication.shared.keyWindow?.rootViewController?.view)

        guard !isActive else {
            // Check if the point's position is inside the defined area.
            if optionsView.contains(point) {
                let relativeSizePerOption = optionsView.frame.width / CGFloat(dataset.count)
                focusOption(withIndex: Int(round((point.x - originPoint.x) / relativeSizePerOption)))
            } else {
                loseFocusFromOptions()
            }
            return
        }
        
        selectedItem = nil
        isActive = true

        let config = self.config
        let sizeBtn = CGSize(width: xPosition(for: dataset.count), height: config.heightForSize)
        resetUI()

        UIView.animate(withDuration: 0.2) {
            self.optionsView.alpha = 1
        }

        for i in 0..<dataset.count {
            let optionFrame = CGRect(x: xPosition(for: i), y: sizeBtn.height * 1.2,
                                     sideSize: DesignConstants.sizeBeforeOpen)
            let option = UIImageView(frame: optionFrame)
            option.image = UIImage(named: dataset[i].image)
            option.alpha = 0.6
            optionsView.addSubview(option)
            
            UIView.animate(withDuration: 0.2, delay: 0.05 * Double(i), options: .curveEaseInOut, animations: {
                option.frame.origin.y = config.spacing
                option.alpha = 1
                option.frame.size = CGSize(sideSize: config.size)
                let sizeCenter = config.size / 2
                option.center = CGPoint(x: optionFrame.origin.x + sizeCenter,
                                        y: config.spacing + sizeCenter)
            }, completion: nil)
        }
    }

    /// Function that collapse and close the Options Selector.
    private func collapse() {
        for (i, option) in optionsView.subviews.enumerated() {
            UIView.animate(withDuration: 0.2, delay: 0.05 * Double(i), options: .curveEaseInOut) {
                option.alpha = 0.3
                option.frame.size = CGSize(sideSize: DesignConstants.sizeBeforeOpen)
            } completion: { (finished) in
                if finished && i == (self.dataset.count / 2) {
                    UIView.animate(withDuration: 0.1, animations: {
                        self.optionsView.alpha = 0
                    }, completion: { (finished) -> Void in
                        self.isActive = false
                        self.backgroundView.removeFromSuperview()
                        if let selectedItem = self.selectedItem {
                            self.delegate?.selectedOption(self, index: selectedItem)
                        } else {
                            self.delegate?.cancelledAction(self)
                        }
                    })
                }
            }
        }
    }

    /// A function intended to animate the selector and the options,
    /// in case the user is not focusing a specific option.
    private func loseFocusFromOptions() {
        selectedItem = nil
        UIView.animate(withDuration: 0.3) {
            for (idx, view) in self.optionsView.subviews.enumerated() {
                view.frame = CGRect(x: self.xPosition(for: idx), y: self.config.spacing, sideSize: self.config.size)
            }
        }
    }

    /// When a user in focusing an option, that option should magnify.
    ///
    /// - Parameter index: The index of the option in the dataset.
    private func focusOption(withIndex index: Int) {
        guard index >= 0 && index < dataset.count else { return }
        selectedItem = index
        let config = self.config
        var last: CGFloat = index != 0 ? config.spacing : 0
        let centerYForOption = optionsView.bounds.height/2
        
        UIView.animate(withDuration: 0.3) {
            for (idx, view) in self.optionsView.subviews.enumerated() {
                view.frame = CGRect(x: last, y: config.spacing, sideSize: config.minSize)
                switch idx {
                case (index-1):
                    view.center.y = centerYForOption
                    last += config.minSize
                case index:
                    view.frame = CGRect(x: last, y: -(config.maxSize/2), sideSize: config.maxSize)
                    last += config.maxSize
                default:
                    view.center.y = centerYForOption
                    last += config.minSize + config.spacing
                }
            }
        }
    }

    /// Calculate the `x` position for a given dataset option.
    ///
    /// - Parameter option: the position of the option in the dataset. <0... dataset.count>.
    /// - Returns: The x position for a given option.
    private func xPosition(for option: Int) -> CGFloat {
        let option = CGFloat(option)
        return (option + 1) * config.spacing + config.size * option
    }

    /// Reset the UI to the initial state.
    private func resetUI() {
        originPoint = superview?.convert(frame.origin, to: nil) ?? .zero

        if originPoint != frame.origin {
            backgroundView.frame.origin.x -= originPoint.x
            backgroundView.frame.origin.y -= originPoint.y
        }
        
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(backgroundView)

        let optionsViewSize = CGSize(width: xPosition(for: dataset.count), height: config.heightForSize)
        let optionsViewOrigin = CGPoint(x: originPoint.x, y: originPoint.y - optionsViewSize.height)
        optionsView = UIView(frame: CGRect(origin: optionsViewOrigin, size: optionsViewSize))
        optionsView.layer.cornerRadius  = optionsView.frame.height / 2
        optionsView.backgroundColor     = .white
        optionsView.layer.shadowColor   = UIColor.lightGray.cgColor
        optionsView.layer.shadowOffset  = .zero
        optionsView.layer.shadowOpacity = 0.5
        optionsView.alpha               = 0.3
        backgroundView.addSubview(optionsView)
    }
}
