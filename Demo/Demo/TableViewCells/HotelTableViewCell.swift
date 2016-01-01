//
//  StayTableViewCell.swift
//  goru
//
//  Created by Pham Ba Tho on 12/4/15.
//  Copyright © 2015 Silicon Straits. All rights reserved.
//

import UIKit
import LazyTableView
import HCSStarRatingView

class HotelTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var topImageView: UIImageView!
    
    @IBOutlet weak var ratingPointLabel: UILabel!
    @IBOutlet weak var ratingTextLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starRatingView: HCSStarRatingView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.selectionStyle = .None
    }
}

// MARK: TableViewCell Configurations
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