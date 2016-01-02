#LazyTableView
A lazy way for smart developers to deal with UITableView.

## Why LazyTableView?
How many times do you have to implement UITableViewDatasource and UITableViewDelegate?<br />
Is it boring? And how to deal with different UITableViewCells in one TableView?

You're smart, so you need a smart way to do it.<br />
LazyTableView is for you, it's easy to display model in UITableView. Also support different UITableViewCells.
### Traditional way
![alt tag] (https://github.com/tuanphung/LazyTableView/blob/master/Assets/OldWay.png)

Your ViewController have to:
- Implement a lot of methods to adapt UITableViewDatasource and UITableViewDelegate.
- Do some suck things like `if else` condition if you need to display different UITableViewCells in one TableView.
- Maintain models.
- Hard to reuse UITableView.

### Lazy way
![alt tag] (https://github.com/tuanphung/LazyTableView/blob/master/Assets/LazyWay.png)

So now:
- Don't need to implement any methods of UITableViewDatasource and UITableViewDelegate. Most should be done in UITableViewCell.
- It's super easy to reuse UITableViewCell.
- Models are managed by LazyTableView, not ViewController anymore.
- Allow displaying UITableViewCells base on model type without pain. After some setups, just push models to LazyTableView, then cell will automatically pick up models and display them.

## Usage
### Setup Your Model
Nothing special, just reuse models you made before.

For example, I create two models below:
```swift
class Restaurant {
    // Properties
    var name: String = ""
    var imageName: String = ""
    var numberOfReviews: Int = 0
    var rating: Double = 0
}
```

```swift
class Hotel {
    // Properties
    var name: String = ""
    var imageName: String = ""
    var price: Double = 0
    var userRating: Double = 0
    var rating: Double = 0
}
```
### Introduce LazyTableViewCellProtocol
```swift
public protocol LazyTableViewCellProtocol: NSObjectProtocol {
    static func reuseIdentifier() -> String
    
    static func nibName() -> String?
    
    static func nib() -> UINib?
    
    static func height(model: AnyObject) -> CGFloat
    
    // Define what class of model that Cell can display. It will ignore all models that type is not in list.
    // This method is required overriding.
    static func acceptableModelTypes() -> [AnyClass]
    
    // Define how to map properties of model to UI.
    // This method is required overriding.
    func configureCell(model: AnyObject)
}
```

### Setup your TableViewCell
LazyTableView only accept LazyTableViewCellProcotol because it require some methods. So your UITableViewCell must implement LazyTableViewCellProcotol.<br />
However, you don't need implement all, some methods already have default implementation.

`By default, your cell Identifier is same to class name. If you use XIB to layout cell, you have to set Identifier is your class name.`

```swift
class RestaurantTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var starRatingView: HCSStarRatingView!
}

extension RestaurantTableViewCell: LazyTableViewCellProtocol {
    static func acceptableModelTypes() -> [AnyClass] {
        return [Restaurant.self]
    }
    
    static func height(model: AnyObject) -> CGFloat {
        return 230
    }
    
    func configureCell(model: AnyObject) {
        if let restaurant = model as? Restaurant {
            self.titleLabel.text = restaurant.name
            self.reviewLabel.text = "\(restaurant.numberOfReviews) review" + (restaurant.numberOfReviews > 1 ? "s" : "")
            self.topImageView.image = UIImage(named: restaurant.imageName)
    
            self.starRatingView.value = CGFloat(restaurant.rating)
        }
    }
}
```

```swift
class HotelTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var ratingPointLabel: UILabel!
    @IBOutlet weak var ratingTextLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starRatingView: HCSStarRatingView!
    @IBOutlet weak var priceLabel: UILabel!
}

extension HotelTableViewCell: LazyTableViewCellProtocol {
    static func acceptableModelTypes() -> [AnyClass] {
        return [Hotel.self]
    }
    
    static func height(model: AnyObject) -> CGFloat {
        return 250
    }
    
    func configureCell(model: AnyObject) {
        if let hotel = model as? Hotel {
            self.titleLabel.text = hotel.name
            self.topImageView.image = UIImage(named: hotel.imageName)
            self.starRatingView.value = CGFloat(hotel.rating)
            self.ratingPointLabel.text = "\(hotel.userRating)"
            self.priceLabel.text = "\(hotel.price) $"
        }
    }
}
```
Finally! Your cells are ready to use.

### Displaying Models
In your ViewController, not too much works to do.

1.Register your cells:
```swift
self.lazyTableView.register([RestaurantTableViewCell.self, HotelTableViewCell.self])
```
2.Push your models:
```swift
let restaurant = Restaurant()
... // Some extra initializion

let hotel = Hotel()
... // Some extra initializion

self.lazyTableView.addItems([restaurant, hotel])
```

3.Enjoys it!

![alt tag](https://github.com/tuanphung/LazyTableView/blob/master/Assets/Demo.gif)

### Handle click event on Cell
```swift
self.lazyTableView.onDidSelectItem = { [weak self] item in
    // Handle selected item here
    ...
}
```

### Lazy loading models from Network
Coming soon...

## Requirements
- iOS 8.0+ / Mac OS X 10.9+
- Xcode 6.4

## Installation
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

## License

LazyTableView is released under the MIT license. See LICENSE for details.
