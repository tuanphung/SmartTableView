#LazyTableView
New way to render model on UITableViewCell. Allow displaying multiple models and cells automatically.

## Why LazyTableView?
### Traditional way
{ Image }
- Your ViewController have to implement a lot of methods to adapt UITableViewDatasource and UITableViewDelegate.
- You have to do something like `if else` condition if you need to display multiple kind of cell with multiple models.
- You have to maintain array of models in ViewController.
- Hard to reuse UITableView.

### LazyTableView way
{ Image }
- ViewController don't need to implement any methods of UITableViewDatasource and UITableViewDelegate.
- Everything should be done in UITableViewCell, so it's super easy for resuable.
- Models are managed by LazyTableView.
- Allow displaying different kinds of model without pain, just push models to LazyTableView, then cell will automatically pick up models then display them.

## Usage
### Setup Your Model
Nothing special, just reuse your model you made.
For example, I setup Restaurant & Hotel model like this:
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
    
    // Draft behaviour
    // In case a model is displayed by multiple Cells, use pairCode to match model and cell.
    // Paircode only is checked if model have a paircode setup.
    // If paircode is not setup in model, just need to check mapping class type.
    // If paircode is setup in model, and it's same to cell's paircode, it's matched. Otherwise, cell will not pick up that model to display.
    static func pairCode() -> Int?
    
    // Define what class of model that Cell can display. It will ignore all models that type is not in list.
    // This method is required overriding.
    static func acceptableModelTypes() -> [AnyClass]
    
    // Define how to map properties of model to UI.
    // This method is required overriding.
    func configureCell(model: AnyObject)
}
```

### Setup your TableViewCell
UITableViewCell have to implement LazyTableViewCellProcotol, LazyTableView require some methods. You don't need implement all, because some methods already have default implementation.
```swift
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
So, your cells are ready to use.

### Displaying Models
In your ViewController, not too much works to do, you just need to do 2 steps:
1. Register your cells:
```swift
self.lazyTableView.register([RestaurantTableViewCell.self, HotelTableViewCell.self])
```
2. Push your models:
```swift
let restaurant = Restaurant()
... // Some init here

let hotel = Hotel()
... // Some init here

self.lazyTableView.addItems([restaurant, hotel])
```

Cheers!

![alt tag](https://github.com/tuanphung/LazyTableView/blob/master/Demo.gif)

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
