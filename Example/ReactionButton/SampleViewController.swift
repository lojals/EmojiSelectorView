//
//  SampleViewController.swift
//  ReactionButton
//
//  Created by Jorge R Ovalle Z on 2/28/16.
//

import UIKit
import ReactionButton

final class SampleViewController: UIViewController {

    @IBOutlet weak var selectorView: ReactionButton!
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

// MARK: ReactionButtonDelegate
extension SampleViewController: ReactionButtonDelegate {
    
    func ReactionSelector(_ sender: ReactionButton, didSelectedIndex index: Int) {
        informationLabel.text = "Option \(index) selected"
    }

    func ReactionSelector(_ sender: ReactionButton, didChangeFocusTo index: Int?) {
        guard let index = index else {
            informationLabel.text = "Lose focus"
            return
        }

        informationLabel.text = "Focused on \(index) option"
    }

    func ReactionSelectorDidCancelledAction(_ sender: ReactionButton) {
        informationLabel.text = "User cancelled selection"
    }

}

// MARK: ReactionButtonDataSource
extension SampleViewController: ReactionButtonDataSource {
    
    func numberOfOptions(in selector: ReactionButton) -> Int {
        optionsDataset.count
    }
    
    func ReactionSelector(_ selector: ReactionButton, viewForIndex index: Int) -> UIView {
        let option = optionsDataset[index].imageName
        guard let image = UIImage(named: option) else {
            return UIView()
        }
        return UIImageView(image: image)
    }
    
    func ReactionSelector(_ selector: ReactionButton, nameForIndex index: Int) -> String {
        optionsDataset[index].title
    }
    
}
