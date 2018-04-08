//
//  ViewController.swift
//  JOEmojiableBtn
//
//  Created by Jorge Raul Ovalle Zuleta on 2/28/16.
//  Copyright © 2018 Jorge Ovalle. All rights reserved.
//

import UIKit
import JOEmojiableBtn

class ViewController: UIViewController, JOEmojiableDelegate {
    enum DesignConstants {
        static var mainSampleColor = UIColor(red: 0.27, green: 0.69, blue: 0.67, alpha: 1)
        static var buttonCornerRadius: CGFloat = 25
        static var buttonFontLabel = UIFont.systemFont(ofSize: 11)
        static var sampleButtonSize = CGSize(width: 100, height: 50)
    }
    
    let optionsDataset = [
        JOEmojiableOption(image: "img_1", name: "dislike"),
        JOEmojiableOption(image: "img_2", name: "broken"),
        JOEmojiableOption(image: "img_3", name: "he he"),
        JOEmojiableOption(image: "img_4", name: "ooh"),
        JOEmojiableOption(image: "img_5", name: "meh!"),
        JOEmojiableOption(image: "img_6", name: "ahh!")
    ]
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 30, width: self.view.frame.width, height: 30))
        label.text = "Long tap in the buttons"
        label.textColor = DesignConstants.mainSampleColor
        label.textAlignment = .center
        return label
    }()
    
    
    lazy var labelInfo: UILabel = {
        let labelInfo = UILabel(frame: CGRect(x: 0, y: 60, width: self.view.frame.width, height: 30))
        labelInfo.text = ""
        labelInfo.textColor = UIColor(red: 0.27, green: 0.69, blue: 0.67, alpha: 1)
        labelInfo.textAlignment = .center
        return labelInfo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(label)
        view.addSubview(labelInfo)

        let buttonSample1 = JOEmojiableBtn(frame: CGRect(origin: CGPoint(x: 40, y: 200),
                                                         size: DesignConstants.sampleButtonSize))
        buttonSample1.delegate = self
        buttonSample1.backgroundColor = DesignConstants.mainSampleColor
        buttonSample1.titleLabel?.font = DesignConstants.buttonFontLabel
        buttonSample1.layer.cornerRadius = DesignConstants.buttonCornerRadius
        buttonSample1.setTitle("Long-tap me!", for: [.normal])
        buttonSample1.dataset = optionsDataset
        view.addSubview(buttonSample1)

        let config = JOEmojiableConfig(spacing: 2,
                                       size: 30,
                                       minSize: 34,
                                       maxSize: 45,
                                       spaceBetweenComponents: 30)
        
        let buttonSample2 = JOEmojiableBtn(frame: CGRect(origin: CGPoint(x: 40, y: 300),
                                                         size: DesignConstants.sampleButtonSize),
                                           config: config)
        buttonSample2.delegate = self
        buttonSample2.backgroundColor = DesignConstants.mainSampleColor
        buttonSample2.titleLabel?.font = DesignConstants.buttonFontLabel
        buttonSample2.layer.cornerRadius = DesignConstants.buttonCornerRadius
        buttonSample2.setTitle("Long-tap me!", for: [.normal])
        buttonSample2.dataset = optionsDataset
        view.addSubview(buttonSample2)

    }

    func singleTap(_ sender: JOEmojiableBtn) {
        print("Single tap action")
        labelInfo.text = "Single tap action"
    }

    func selectedOption(_ sender: JOEmojiableBtn, index: Int) {
        print("Option \(index) selected")
        labelInfo.text = "Option \(index) selected"
    }

    func cancelledAction(_ sender: JOEmojiableBtn) {
        print("User cancelled selection")
        labelInfo.text = "User cancelled selection"
    }

}
