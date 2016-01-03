#Examples

## Setup Your Model
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

### Setup your UITableViewCell
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

![alt tag](https://github.com/tuanphung/LazyTableView/blob/master/Doc/Assets/Demo.gif)

### Handle click event on Cell
```swift
self.lazyTableView.onDidSelectItem = { [weak self] item in
    // Handle selected item here
    ...
}
```

### Lazy loading models from Network
Coming soon...
