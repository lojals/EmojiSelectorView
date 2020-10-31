//
//  EmojiSelectorView.swift
//  EmojiSelectorView
//
//  Created by Jorge Raul Ovalle Zuleta on 2/28/16.
//

import UIKit

/// A type that represents the selector with options froma items.
public final class EmojiSelectorView: UIButton {
    
    private let sizeBeforeOpen: CGFloat = 10
    
    public weak var delegate: EmojiSelectorViewDelegate?
    public weak var dataSource: EmojiSelectorViewDataSource?
    
    private var isActive: Bool = false
    
    public private (set) var selectedItem: Int? {
        didSet {
            delegate?.emojiSelector(self, didChangeFocusTo: selectedItem)
        }
    }
    
    private lazy var optionsView: UIView = {
        let optionsView = UIView(frame: .zero)
        optionsView.layer.cornerRadius = config.heightForSize/2
        optionsView.backgroundColor = .white
        optionsView.layer.shadowColor = UIColor.lightGray.cgColor
        optionsView.layer.shadowOffset = .zero
        optionsView.layer.shadowOpacity = 0.5
        optionsView.alpha = 0.3
        return optionsView
    }()
    
    private let config: EmojiSelectorView.Config
    
    private var rootView: UIView? {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.view
    }
    
    // MARK: - View lifecycle
    
    /// Creates a new instace of `EmojiSelectorView`.
    ///
    /// - Parameters:
    ///   - frame: Frame of the button will open the selector
    ///   - config: The custom configuration for the UI components.
    public override init(frame: CGRect) {
        self.config = .default
        super.init(frame: frame)
        
        addGestureRecognizer(UILongPressGestureRecognizer(target: self,
                                                          action: #selector(EmojiSelectorView.handlePress(sender:))))

    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.config = .default
        super.init(coder: aDecoder)
     
        addGestureRecognizer(UILongPressGestureRecognizer(target: self,
                                                          action: #selector(EmojiSelectorView.handlePress(sender:))))
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
        guard let dataSource = dataSource else {
            return
        }
        
        selectedItem = nil
        isActive = true
        
        let itemsCount = dataSource.numberOfOptions(in: self)
        
        let originPoint = rootView?.convert(frame.origin, to: nil) ?? .zero
        optionsView.frame = config.rect(items: itemsCount,
                                        originalPos: originPoint,
                                        trait: UIScreen.main.traitCollection)
        
        let config = self.config
        let sizeBtn = CGSize(width: xPosition(for: itemsCount), height: config.heightForSize)
        
        rootView?.addSubview(optionsView)
        
        UIView.animate(withDuration: 0.2) {
            self.optionsView.alpha = 1
        }
        
        for index in 0..<itemsCount {
            let optionFrame = CGRect(x: xPosition(for: index), y: sizeBtn.height * 1.2,
                                     sideSize: sizeBeforeOpen)
            let option = dataSource.emojiSelector(self, viewForIndex: index)
            option.frame = optionFrame
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
        guard let dataSource = dataSource else {
            return
        }
        // Check if the point's position is inside the defined area.
        if optionsView.contains(point) {
            let relativeSizePerOption = optionsView.frame.width / CGFloat(dataSource.numberOfOptions(in: self))
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
                guard let dataSource = self.dataSource, finished,
                      index == dataSource.numberOfOptions(in: self)/2 else {
                    return
                }
                self.isActive = false
                self.optionsView.removeFromSuperview()
                self.optionsView.subviews.forEach { $0.removeFromSuperview() }
                if let selectedItem = self.selectedItem {
                    self.delegate?.emojiSelector(self, didSelectedIndex: selectedItem)
                } else {
                    self.delegate?.emojiSelectorDidCancelledAction(self)
                }
            }
        }
    }
    
    /// When a user in focusing an option, that option should magnify.
    ///
    /// - Parameter index: The index of the option in the items.
    private func focusOption(withIndex index: Int) {
        guard let dataSource = dataSource, (0..<dataSource.numberOfOptions(in: self)).contains(index) else { return }
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
    
    /// Calculate the `x` position for a given items option.
    ///
    /// - Parameter option: the position of the option in the items. <0... items.count>.
    /// - Returns: The x position for a given option.
    private func xPosition(for option: Int) -> CGFloat {
        let option = CGFloat(option)
        return (option + 1) * config.spacing + config.size * option
    }
}
