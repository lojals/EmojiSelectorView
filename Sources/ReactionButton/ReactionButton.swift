//
//  ReactionButton.swift
//  ReactionButton
//
//  Created by Jorge R Ovalle Z on 2/28/16.
//

import UIKit

/// A type that represents the selector with options froma items.
open class ReactionButton: UIButton {
    
    public weak var delegate: ReactionButtonDelegate?
    public weak var dataSource: ReactionButtonDataSource?
    
    private var _dataSource: ReactionButtonDataSource {
        guard let dataSource = dataSource else {
            fatalError("❌ Please set up a datasource for the ReactionButton")
        }
        return dataSource
    }
    
    private var selectedItem: Int? {
        didSet {
            if oldValue != selectedItem {
                delegate?.ReactionSelector(self, didChangeFocusTo: selectedItem)
            }
        }
    }
    
    private lazy var optionsBarView: UIView = {
        let optionsBarView = UIView(frame: .zero)
        optionsBarView.layer.cornerRadius = config.heightForSize/2
        optionsBarView.alpha = 0.3
        return optionsBarView
    }()
    
    private var config: ReactionButton.Config {
        guard let delegate = delegate as? ReactionButtonDelegateLayout else {
            return .default
        }
        return delegate.ReactionSelectorConfiguration(self)
    }
    
    private var rootView: UIView? {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.view
    }
    
    // MARK: - View lifecycle
    
    /// Creates a new instance of `ReactionButton`.
    public convenience init() {
        self.init(frame: .zero)
    }
    
    /// Creates a new instace of `ReactionButton`.
    ///
    /// - Parameters:
    ///   - frame: Frame of the button will open the selector
    ///   - config: The custom configuration for the UI components.
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addGestureRecognizer(UILongPressGestureRecognizer(target: self,
                                                          action: #selector(ReactionButton.handlePress(sender:))))
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
        updateOptionsView(with: UIScreen.main.traitCollection)
        
        let config = self.config
        rootView?.addSubview(optionsBarView)
        
        UIView.animate(withDuration: 0.2) {
            self.optionsBarView.alpha = 1
        }
        
        for i in 0..<_dataSource.numberOfOptions(in: self) {
            let optionFrame = CGRect(x: xPosition(for: i), y: config.heightForSize * 1.2,
                                     sideSize: config.sizeBeforeOpen)
            let option = _dataSource.ReactionSelector(self, viewForIndex: i)
            option.frame = optionFrame
            option.alpha = 0.6
            optionsBarView.addSubview(option)

            UIView.animate(index: i) {
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
        if optionsBarView.contains(point) {
            let relativeSizePerOption = optionsBarView.frame.width / CGFloat(_dataSource.numberOfOptions(in: self))
            focusOption(withIndex: Int(round((point.x - optionsBarView.frame.minX) / relativeSizePerOption)))
        } else {
            selectedItem = nil
            UIView.animate(withDuration: 0.2) {
                for (idx, view) in self.optionsBarView.subviews.enumerated() {
                    view.frame = CGRect(x: self.xPosition(for: idx), y: self.config.spacing, sideSize: self.config.size)
                }
            }
        }
    }
    
    /// Function that collapse and close the Options Selector.
    private func collapse() {
        for (index, option) in optionsBarView.subviews.enumerated() {
            UIView.animate(index: index) {
                option.alpha = 0
                option.frame.size = CGSize(sideSize: self.config.sizeBeforeOpen)
            } completion: { finished in
                guard finished, index == self._dataSource.numberOfOptions(in: self)/2 else {
                    return
                }
                self.optionsBarView.removeFromSuperview()
                self.optionsBarView.subviews.forEach { $0.removeFromSuperview() }
                if let selectedItem = self.selectedItem {
                    self.delegate?.ReactionSelector(self, didSelectedIndex: selectedItem)
                } else {
                    self.delegate?.ReactionSelectorDidCancelledAction(self)
                }
            }
        }
    }
    
    /// When a user in focusing an option, that option should magnify.
    ///
    /// - Parameter index: The index of the option in the items.
    private func focusOption(withIndex index: Int) {
        guard (0..<_dataSource.numberOfOptions(in: self)).contains(index) else { return }
        selectedItem = index
        let config = self.config
        var xCarry: CGFloat = index != 0 ? config.spacing : 0
        
        UIView.animate(withDuration: 0.2) {
            for (i, optionView) in self.optionsBarView.subviews.enumerated() {
                optionView.frame = CGRect(x: xCarry, y: config.spacing, sideSize: config.minSize)
                optionView.center.y = config.heightForSize/2
                switch i {
                case (index-1):
                    xCarry += config.minSize
                case index:
                    optionView.frame = CGRect(x: xCarry, y: -config.maxSize/2, sideSize: config.maxSize)
                    xCarry += config.maxSize
                default:
                    xCarry += config.minSize + config.spacing
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
    
    private func updateOptionsView(with trait: UITraitCollection) {
        let originPoint = superview?.convert(frame.origin, to: rootView) ?? .zero
        
        optionsBarView.backgroundColor = UIColor.background
        optionsBarView.layer.shadowColor = UIColor.shadow.cgColor
        optionsBarView.layer.shadowOpacity = 0.5
        optionsBarView.layer.shadowOffset = .zero
        
        optionsBarView.frame = config.rect(items: _dataSource.numberOfOptions(in: self),
                                        originalPos: originPoint,
                                        trait: trait)
    }
}
