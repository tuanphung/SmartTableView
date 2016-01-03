#LazyTableView
A lazy way for smart developers to deal with UITableView.

Why LazyTableView?
--------------
How many times do you have to implement UITableViewDatasource and UITableViewDelegate?<br />
Is it boring? And how to deal with different UITableViewCells in one TableView?

> You're smart, so you need a smart way to do it.<br />
LazyTableView is for you, it's easy to display model in UITableView. Also support different UITableViewCells.

### Traditional way
![alt tag] (https://github.com/tuanphung/LazyTableView/blob/master/Doc/Assets/OldWay.png)

Your ViewController have to:
- Implement a lot of methods to adapt UITableViewDatasource and UITableViewDelegate.
- Do some suck things like `if else` condition if you need to display different UITableViewCells in one TableView.
- Maintain models.
- Hard to reuse UITableView.

### Lazy way
![alt tag] (https://github.com/tuanphung/LazyTableView/blob/master/Doc/Assets/LazyWay.png)

So now:
- Don't need to implement any methods of UITableViewDatasource and UITableViewDelegate. Most should be done in UITableViewCell.
- It's super easy to reuse UITableViewCell.
- Models are managed by LazyTableView, not ViewController anymore.
- Allow displaying UITableViewCells base on model type without pain. After some setup, just push models to LazyTableView, then cell will automatically pick up models and display them.
- Support Generic and Associated types. So, no type casts required.

Introduce LazyTableViewCellProtocol
--------------
```swift
public protocol LazyTableViewCellProtocol: NSObjectProtocol {
    typealias ModelType
    
    // Optional, default is ClassName
    static func reuseIdentifier() -> String
    
    // Optional, default is ClassName
    static func nibName() -> String?
    
    // Optional, default is `UITableViewAutomaticDimension`
    static func height(model: ModelType) -> CGFloat
    
    // Define how to map properties of model to UI.
    // This method must be implemented.
    func configureCell(model: ModelType)
}
```
Since LazyTableView require some implementations in your cell, so it only accept cells that implemented this protocol.<br />
`Don't need implement all, some methods already have default implementation.`
* Important:
Since LazyTableViewCellProtocol used Associated type. So, no type casts required.
ModelType is based on your cell implementation (in `height:` & `configureCell:` method).

Sample Project
--------------
There's a sample project in the Demo directory. Have fun!

Usage
--------------
After [some setup](Doc/Examples.md), using LazyTableView is really simple. In your ViewController, just do:

1. Register your cells:
```swift
self.lazyTableView.register(RestaurantTableViewCell.self)
self.lazyTableView.register(HotelTableViewCell.self)
```
2. Push your models:
```swift
let restaurant = Restaurant()
... // Some extra initializions

let hotel = Hotel()
... // Some extra initializions

self.lazyTableView.addItems([restaurant, hotel])
```

3. Enjoys it!

![alt tag](https://github.com/tuanphung/LazyTableView/blob/master/Doc/Assets/Demo.gif)

### Handle click event on Cell
Just easy like this:
```swift
self.lazyTableView.onDidSelectItem = { [weak self] item in
    // Handle selected item here
    ...
}
```

### Lazy loading models from Network
Coming soon...

Requirements
--------------
- iOS 8.0+ / Mac OS X 10.9+
- Xcode 6.4

Installation
--------------
[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods
```
To integrate LazyTableView into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'LazyTableView', '~> 1.0'
```

Then, run the following command:

```bash
$ pod install
```

License
--------------
LazyTableView is released under the MIT license. See LICENSE for details.
