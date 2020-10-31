//
//  SampleViewController.swift
//  EmojiSelectorView
//
//  Created by Jorge Raul Ovalle Zuleta on 2/28/16.
//

import UIKit
import EmojiSelectorView

final class SampleViewController: UIViewController {

    @IBOutlet weak var selectorView: EmojiSelectorView!
    @IBOutlet weak var informationLabel: UILabel!
    
    // MARK: Properties definition
    let optionsDataset = [
        EmojiSelectorViewOption(image: "img_1", name: "dislike"),
        EmojiSelectorViewOption(image: "img_2", name: "broken"),
        EmojiSelectorViewOption(image: "img_3", name: "he he"),
        EmojiSelectorViewOption(image: "img_4", name: "ooh"),
        EmojiSelectorViewOption(image: "img_5", name: "meh!"),
        EmojiSelectorViewOption(image: "img_6", name: "ahh!")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectorView.items = optionsDataset
        selectorView.delegate = self
    }

}

// MARK: EmojiSelectorViewDelegate
extension SampleViewController: EmojiSelectorViewDelegate {
    func emojiSelector(_ sender: EmojiSelectorView, didSelectedIndex index: Int) {
        informationLabel.text = "Option \(index) selected"
    }

    func emojiSelector(_ sender: EmojiSelectorView, didChangeFocusTo index: Int?) {
        guard let index = index else {
            informationLabel.text = "Lose focus"
            return
        }

        informationLabel.text = "Focused on \(index) option"
    }

    func emojiSelectorDidCancelledAction(_ sender: EmojiSelectorView) {
        informationLabel.text = "User cancelled selection"
    }

}
