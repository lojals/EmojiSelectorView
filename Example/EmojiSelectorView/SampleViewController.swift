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
    
    let optionsDataset = [
        (imageName: "img_1", title: "Like"),
        (imageName: "img_2", title: "Smile"),
        (imageName: "img_3", title: "Heart"),
        (imageName: "img_4", title: "Idea"),
        (imageName: "img_5", title: "Slow"),
        (imageName: "img_6", title: "Fast")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectorView.delegate = self
        selectorView.dataSource = self
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

// MARK: EmojiSelectorViewDataSource
extension SampleViewController: EmojiSelectorViewDataSource {
    
    func numberOfOptions(in selector: EmojiSelectorView) -> Int {
        optionsDataset.count
    }
    
    func emojiSelector(_ selector: EmojiSelectorView, viewForIndex index: Int) -> UIView {
        let option = optionsDataset[index].imageName
        guard let image = UIImage(named: option) else {
            return UIView()
        }
        return UIImageView(image: image)
    }
    
    func emojiSelector(_ selector: EmojiSelectorView, nameForIndex index: Int) -> String {
        optionsDataset[index].title
    }
    
}


class CustomSelectorView: EmojiSelectorView, EmojiSelectorViewDataSource {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfOptions(in selector: EmojiSelectorView) -> Int {
        return 12
    }
    
    func emojiSelector(_ selector: EmojiSelectorView, viewForIndex index: Int) -> UIView {
        return UIView()
    }
    
    func emojiSelector(_ selector: EmojiSelectorView, nameForIndex index: Int) -> String {
        return ""
    }
}
