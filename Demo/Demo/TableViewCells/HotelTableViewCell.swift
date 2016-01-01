//
//  StayTableViewCell.swift
//  goru
//
//  Created by Pham Ba Tho on 12/4/15.
//  Copyright © 2015 Silicon Straits. All rights reserved.
//

import UIKit
import CoreLocation
import HCSStarRatingView

class StayTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var topImageView: UIImageView!
    
    @IBOutlet weak var ratingPointLabel: UILabel!
    @IBOutlet weak var ratingTextLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starRatingView: HCSStarRatingView!
    
    @IBOutlet weak var distanceIconView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.selectionStyle = .None
        self.topImageView.sd_cancelCurrentImageLoad()
    }
}

// MARK: TableViewCell Configurations
extension StayTableViewCell: StatefulTableViewCellProtocol {
    static func height(model: AnyObject) -> CGFloat {
        return 250
    }
    
    func configureCell(model: AnyObject) {
        if let stay = model as? Stay {
            self.titleLabel.text = stay.name
            
            if let imageURL = stay.images.first {
                self.topImageView.sd_setImageWithURL(NSURL(string: imageURL), placeholderImage: UIImage(named: "meshup-background-placeholder"))
            }
            else {
                self.topImageView.image = UIImage(named: "meshup-background-placeholder")
            }
            
            self.starRatingView.value = CGFloat(stay.rating)
            self.ratingPointLabel.text = "\(stay.userRating)"
            self.ratingTextLabel.text = stay.ratingText
            
            self.priceLabel.text = "\(stay.price) USD"
            
            // Calculate distance
            if let location = GoruServices.getCurrentLocation() {
                let dineLocation = CLLocation(latitude: stay.latitude, longitude: stay.longitude)
                let distance = location.distanceFromLocation(dineLocation)
                
                self.distanceLabel.text = String(format: "%.1f km away", distance)
            }
            else {
                self.distanceLabel.text = "N/A"
            }
        }
    }
}