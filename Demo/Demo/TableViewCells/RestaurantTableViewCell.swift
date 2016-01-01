//
//  DineListTableViewCell.swift
//  goru
//
//  Created by Pham Ba Tho on 12/4/15.
//  Copyright © 2015 Silicon Straits. All rights reserved.
//

import UIKit
import LazyTableView
import HCSStarRatingView

class RestaurantTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var starRatingView: HCSStarRatingView!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.selectionStyle = .None
    }
}

// MARK: TableViewCell Configurations
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
            
            self.priceLabel.text = "\(restaurant.price) $"
        }
    }
}