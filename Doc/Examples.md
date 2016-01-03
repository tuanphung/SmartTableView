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

## Setup your UITableViewCell
`By default, your cell Identifier is same to ClassName. If you use XIB to layout cell, you have to set Identifier is your ClassName.`

LazyTableViewCellProtocol already support Generic and Associated types. So, no type casts required.<br />
Your cell only accept model that same in `height:` & `configureCell:` method.

### RestaurantTableViewCell
```swift
class RestaurantTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var starRatingView: HCSStarRatingView!
}

extension RestaurantTableViewCell: LazyTableViewCellProtocol {
    static func height(restaurant: Restaurant) -> CGFloat {
        return 230
    }
    
    func configureCell(restaurant: Restaurant) {
        self.titleLabel.text = restaurant.name
        self.reviewLabel.text = "\(restaurant.numberOfReviews) review" + (restaurant.numberOfReviews > 1 ? "s" : "")
        self.topImageView.image = UIImage(named: restaurant.imageName)
        self.starRatingView.value = CGFloat(restaurant.rating)
    }
}
```
`RestaurantTableViewCell` will only accept `Restaurant` model. Others will be ignored.

### HotelTableViewCell
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
    static func height(hotel: Hotel) -> CGFloat {
        return 250
    }
    
    func configureCell(hotel: Hotel) {
        self.titleLabel.text = hotel.name
        self.topImageView.image = UIImage(named: hotel.imageName)
        self.starRatingView.value = CGFloat(hotel.rating)
        self.ratingPointLabel.text = "\(hotel.userRating)"
        self.priceLabel.text = "\(hotel.price) $"
    }
}
```
`HotelTableViewCell` will only accept `Hotel` model. Others will be ignored.

## Displaying Models
Finally! Your cells are ready to use. Now, let's display models on cells, actually it's really easy.<br />

In your ViewController:

1.Register your cells:
```swift
self.lazyTableView.register(RestaurantTableViewCell.self)
self.lazyTableView.register(HotelTableViewCell.self)
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

## Handle click event on Cell
```swift
self.lazyTableView.onDidSelectItem = { [weak self] item in
    // Handle selected item here
    ...
}
```

## Lazy loading models from Network
Coming soon...
