<p align="center">
<a href='#'><img src="https://user-images.githubusercontent.com/6756995/97817645-5e0a3780-1c63-11eb-85be-519f76fc2beb.png"></a>
</p>
<p align="center">
<a href='#'><img src="https://img.shields.io/badge/Language-%20Swift%20-FF00.svg"></a>
<a href="http://cocoapods.org/pods/ReactionButton"><img src="https://img.shields.io/cocoapods/v/ReactionButton.svg?style=flat"></a>
<a href="https://swift.org/package-manager/"><img src="https://img.shields.io/badge/SPM-supported-FF00.svg?style=flat"></a>
<br />
<a href="https://raw.githubusercontent.com/onevcat/ReactionButton/master/LICENSE"><img src="https://img.shields.io/cocoapods/l/ReactionButton.svg?style=flat"></a>
<a href="http://cocoadocs.org/docsets/ReactionButton"><img src="https://img.shields.io/cocoapods/p/ReactionButton.svg?style=flat"></a>
</p>

<p align="center">Since Facebook introduced reactions in 2016, it became a standard in several applications as a way for users to interact with content. ReactionButton is a control that allows developers to add this functionality to their apps in an easy way.</p>

## Features
- [x] Support of Dark Mode
- [x] Customizable layout using `ReactionButtonDelegateLayout`
- [x] Extensible DataSource for the control
- [x] Layout support for scrolling interfaces (UICollectionView/UITableView)
- [x] Codable initializer for usage on storyboards
- [x] Events

## Requirements
* iOS 13.0+
* Swift 5.0+

## Installation

* [Installation guide](https://github.com/lojals/ReactionButton/wiki/Installation-guide)

## Usage

### 1. Basic Instance
There are multiple ways to instantiate a `ReactionButton`, using a frame, storyboards, or an empty convenience initializer.

#### Example Code

```swift
let buttonSample = ReactionButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
buttonSample.dataSource = self
view.addSubview(buttonSample)
```

![Basic usage](https://user-images.githubusercontent.com/6756995/97816507-652d4780-1c5b-11eb-8479-0d003197b149.gif)
> Images from [Trump reactionpacks style](http://www.reactionpacks.com/packs/2c1a1e41-e9e9-407a-a532-3bfdfef6b3e6).

### 2. Delegate
The `ReactionButton` has a delegate to communicate events of option selection, option focus, and cancel of actions. To use it, set the `ReactionButtonDelegate` conform as a delegate.

```swift
let buttonSample = ReactionButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
buttonSample.delegate = self
view.addSubview(buttonSample)
```
![Delegate example](https://user-images.githubusercontent.com/6756995/97816887-4e3c2480-1c5e-11eb-9028-5fed1ed22458.gif)
> Images from [Trump reactionpacks style](http://www.reactionpacks.com/packs/2c1a1e41-e9e9-407a-a532-3bfdfef6b3e6).

### 3. Custom layout instance
`ReactionButton` allows customization of the layout with the help of `ReactionButtonDelegateLayout`. To use it, please conform to that protocol and set it as delegate (Same pattern as UICollectionView).

```swift
func ReactionSelectorConfiguration(_ selector: ReactionButton) -> ReactionButton.Config {
  ReactionButton.Config(spacing: 2,
                        size: 30,
                        minSize: 34,
                        maxSize: 45,
                        spaceBetweenComponents: 30)
}
```
You can custom your selector with the following variables, used in the 

![Map 1](https://user-images.githubusercontent.com/6756995/38659568-b0955e30-3def-11e8-85fb-317b3f4cbc36.png)

![New](https://user-images.githubusercontent.com/6756995/97817123-0cac7900-1c60-11eb-8df3-09ba7c19908b.png)


## Author
Jorge Ovalle, jroz9105@gmail.com
