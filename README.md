# EmojiSelectorView

[![Version](https://img.shields.io/cocoapods/v/EmojiSelectorView.svg?style=flat)](http://cocoapods.org/pods/EmojiSelectorView)
[![License](https://img.shields.io/cocoapods/l/EmojiSelectorView.svg?style=flat)](http://cocoapods.org/pods/EmojiSelectorView)
[![Platform](https://img.shields.io/cocoapods/p/EmojiSelectorView.svg?style=flat)](http://cocoapods.org/pods/EmojiSelectorView)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### 📱🍕📱🍕📱🍕📱🍕📱

 ---

## Installation

EmojiSelectorView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "EmojiSelectorView"
```

## Examples

### 1. Basic Instance
This instance create a **EmojiSelectorView** using `default`  EmojiSelectorViewConfig.
Images from  [Trump reactionpacks style](http://www.reactionpacks.com/packs/2c1a1e41-e9e9-407a-a532-3bfdfef6b3e6).

#### Example Code

```swift
let optionsDataset = [
    JOEmojiableOption(image: "img_1", name: "img1"),
    JOEmojiableOption(image: "img_2", name: "img2"),
    JOEmojiableOption(image: "img_3", name: "img3"),
    JOEmojiableOption(image: "img_4", name: "img4"),
    JOEmojiableOption(image: "img_5", name: "img5"),
    JOEmojiableOption(image: "img_6", name: "img6")
]

let buttonSample1 = EmojiSelectorView(frame: CGRect(origin: CGPoint(x: 40, y: 200), size: CGSize(width: 100, height: 50)))
buttonSample1.delegate = self
buttonSample1.backgroundColor = .green
buttonSample1.dataset = optionsDataset
view.addSubview(buttonSample1)
```

![Sample 1](https://user-images.githubusercontent.com/6756995/38659390-fa14b908-3dee-11e8-8885-df6828c07843.gif)


### 2. Custom styled instance
#### Example Code

With this instance you can fully custom your component. Following the **JOEmojiableConfig** variables.

You can custom your selector with the following variables, used in the 

![687474703a2f2f692e696d6775722e636f6d2f65347a616179652e706e673f31](https://user-images.githubusercontent.com/6756995/38659568-b0955e30-3def-11e8-85fb-317b3f4cbc36.png)

![image](http://i.imgur.com/yNfyP3c.png?1)

```swift
let config = JOEmojiableConfig(spacing: 2,
                                size: 30,
                                minSize: 34,
                                maxSize: 45,
                                spaceBetweenComponents: 30)

let buttonSample2 = EmojiSelectorView(frame: CGRect(origin: CGPoint(x: 40, y: 300), size: CGSize(width: 100, height: 50)), config: config)
buttonSample2.delegate = self
buttonSample2.backgroundColor = .green
buttonSample2.dataset = optionsDataset
view.addSubview(buttonSample2)
```

## Author

Jorge Ovalle, jroz9105@gmail.com


![image](http://stream1.gifsoup.com/webroot/animatedgifs/808678_o.gif)



## License

EmojiSelectorView is available under the MIT license. See the LICENSE file for more info.
