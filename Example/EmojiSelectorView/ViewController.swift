//
//  ViewController.swift
//  EmojiSelectorView
//
//  Created by Jorge Raul Ovalle Zuleta on 2/28/16.
//

import UIKit
import EmojiSelectorView

final class ViewController: UIViewController, EmojiSelectorViewDelegate {

    // MARK: DesignConstants
    enum DesignConstants {
        static var mainSampleColor = UIColor(red: 0.27, green: 0.69, blue: 0.67, alpha: 1)
        static var buttonCornerRadius: CGFloat = 25
        static var buttonFontLabel = UIFont.systemFont(ofSize: 11)
        static var sampleButtonSize = CGSize(width: 100, height: 50)
    }

    // MARK: Properties definition
    let optionsDataset = [
        EmojiSelectorViewOption(image: "img_1", name: "dislike"),
        EmojiSelectorViewOption(image: "img_2", name: "broken"),
        EmojiSelectorViewOption(image: "img_3", name: "he he"),
        EmojiSelectorViewOption(image: "img_4", name: "ooh"),
        EmojiSelectorViewOption(image: "img_5", name: "meh!"),
        EmojiSelectorViewOption(image: "img_6", name: "ahh!")
    ]

    private var label: UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 30, width: self.view.frame.width, height: 30))
        label.text = "Long tap in the buttons"
        label.textColor = DesignConstants.mainSampleColor
        label.textAlignment = .center
        return label
    }

    private lazy var labelInfo: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 60, width: self.view.frame.width, height: 30))
        label.text = ""
        label.textColor = UIColor(red: 0.27, green: 0.69, blue: 0.67, alpha: 1)
        label.textAlignment = .center
        return label
    }()

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(label)
        view.addSubview(labelInfo)

        // Sample using `default` configuration.
        let buttonSample1 = EmojiSelectorView(frame: CGRect(origin: CGPoint(x: 40, y: 200),
                                                            size: DesignConstants.sampleButtonSize),
                                              items: optionsDataset)
        buttonSample1.delegate = self
        buttonSample1.backgroundColor = DesignConstants.mainSampleColor
        buttonSample1.titleLabel?.font = DesignConstants.buttonFontLabel
        buttonSample1.layer.cornerRadius = DesignConstants.buttonCornerRadius
        buttonSample1.setTitle("Long-tap me!", for: [.normal])
        view.addSubview(buttonSample1)
    }

    // MARK: JOEmojiableDelegate
    func selectedOption(_ sender: EmojiSelectorView, index: Int) {
        print("Option \(index) selected")
        labelInfo.text = "Option \(index) selected"
    }

    func cancelledAction(_ sender: EmojiSelectorView) {
        print("User cancelled selection")
        labelInfo.text = "User cancelled selection"
    }

}
