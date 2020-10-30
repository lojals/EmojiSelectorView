//
//  EmojiSelectorView.swift
//  EmojiSelectorView
//
//  Created by Jorge Raul Ovalle Zuleta on 2/28/16.
//

import UIKit

/// A type that represents the selector with options froma dataset.
public final class EmojiSelectorView: UIButton {
    
    private let sizeBeforeOpen: CGFloat = 10
    
    public weak var delegate: EmojiSelectorViewDelegate?
    
    public var dataset: [EmojiSelectorViewOption] = []
    
    private var isActive: Bool = false
    
    public private (set) var selectedItem: Int?
    
    private lazy var backgroundView: UIView = {
        let backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = .clear
        return backgroundView
    }()
    
    private lazy var optionsView: UIView = {
        let optionsViewSize = CGSize(width: xPosition(for: dataset.count), height: config.heightForSize)
        let optionsView = UIView(frame: CGRect(origin: .zero, size: optionsViewSize))
        optionsView.layer.cornerRadius = optionsView.frame.height / 2
        optionsView.backgroundColor = .white
        optionsView.layer.shadowColor = UIColor.lightGray.cgColor
        optionsView.layer.shadowOffset = .zero
        optionsView.layer.shadowOpacity = 0.5
        optionsView.alpha = 0.3
        backgroundView.addSubview(optionsView)
        return optionsView
    }()
    
    private let config: EmojiSelectorView.Config
    
    private var rootView: UIView? {
        return UIApplication.shared.keyWindow?.rootViewController?.view
    }
    
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
        
        addGestureRecognizer(UILongPressGestureRecognizer(target: self,
                                                          action: #selector(EmojiSelectorView.handlePress(sender:))))
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Visual component interaction / animation
    
    /// Function that open and expand the Options Selector.
    @objc private func handlePress(sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            expand()
        case .changed:
            let point = sender.location(in: rootView)
            move(point)
        case .ended:
            collapse()
        default: break
        }
    }
    
    private func expand() {
        selectedItem = nil
        isActive = true
        
        let config = self.config
        let sizeBtn = CGSize(width: xPosition(for: dataset.count), height: config.heightForSize)
        
        let originPoint = rootView?.convert(frame.origin, to: nil) ?? .zero
        rootView?.addSubview(backgroundView)
        
        let originalSize = optionsView.frame.size
        let optionsViewOrigin = CGPoint(x: originPoint.x, y: originPoint.y - originalSize.height - 10)
        optionsView.frame = CGRect(origin: optionsViewOrigin, size: originalSize)
        
        UIView.animate(withDuration: 0.2) {
            self.optionsView.alpha = 1
        }
        
        for index in 0..<dataset.count {
            let optionFrame = CGRect(x: xPosition(for: index), y: sizeBtn.height * 1.2,
                                     sideSize: sizeBeforeOpen)
            let option = UIImageView(frame: optionFrame)
            option.image = UIImage(named: dataset[index].image)
            option.alpha = 0.6
            optionsView.addSubview(option)
            
            UIView.animate(index: index) {
                option.frame.origin.y = config.spacing
                option.alpha = 1
                option.frame.size = CGSize(sideSize: config.size)
                let sizeCenter = config.size/2
                option.center = CGPoint(x: optionFrame.origin.x + sizeCenter,
                                        y: config.spacing + sizeCenter)
            }
        }
    }
    
    private func move(_ point: CGPoint) {
        // Check if the point's position is inside the defined area.
        if optionsView.contains(point) {
            let relativeSizePerOption = optionsView.frame.width / CGFloat(dataset.count)
            focusOption(withIndex: Int(round((point.x - optionsView.frame.minX) / relativeSizePerOption)))
        } else {
            selectedItem = nil
            UIView.animate(withDuration: 0.2) {
                for (idx, view) in self.optionsView.subviews.enumerated() {
                    view.frame = CGRect(x: self.xPosition(for: idx), y: self.config.spacing, sideSize: self.config.size)
                }
            }
        }
    }
    
    /// Function that collapse and close the Options Selector.
    private func collapse() {
        for (index, option) in optionsView.subviews.enumerated() {
            UIView.animate(index: index) {
                option.alpha = 0
                option.frame.size = CGSize(sideSize: self.sizeBeforeOpen)
            } completion: { finished in
                guard finished, index == self.dataset.count/2 else { return }
                self.isActive = false
                self.backgroundView.removeFromSuperview()
                self.optionsView.subviews.forEach { $0.removeFromSuperview() }
                if let selectedItem = self.selectedItem {
                    self.delegate?.selectedOption(self, index: selectedItem)
                } else {
                    self.delegate?.cancelledAction(self)
                }
            }
        }
    }
    
    /// When a user in focusing an option, that option should magnify.
    ///
    /// - Parameter index: The index of the option in the dataset.
    private func focusOption(withIndex index: Int) {
        guard (0..<dataset.count).contains(index) else { return }
        selectedItem = index
        let config = self.config
        var last: CGFloat = index != 0 ? config.spacing : 0
        let centerYForOption = optionsView.bounds.height/2
        
        UIView.animate(withDuration: 0.2) {
            for (idx, view) in self.optionsView.subviews.enumerated() {
                view.frame = CGRect(x: last, y: config.spacing, sideSize: config.minSize)
                switch idx {
                case (index-1):
                    view.center.y = centerYForOption
                    last += config.minSize
                case index:
                    view.frame = CGRect(x: last, y: -config.maxSize/2, sideSize: config.maxSize)
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
}
