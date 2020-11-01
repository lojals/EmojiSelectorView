//
//  SampleTableViewController.swift
//  EmojiSelectorView_Example
//
//  Created by Jorge Ovalle on 31/10/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import EmojiSelectorView

final class SampleTableViewController: UITableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
    }

}

final class CustomSelectorView: EmojiSelectorView, EmojiSelectorViewDataSource {
    
    let optionsDataset = [
        (imageName: "img_1", title: "Like"),
        (imageName: "img_2", title: "Smile"),
        (imageName: "img_3", title: "Heart"),
        (imageName: "img_4", title: "Idea"),
        (imageName: "img_5", title: "Slow"),
        (imageName: "img_6", title: "Fast")
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
    }
    
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
