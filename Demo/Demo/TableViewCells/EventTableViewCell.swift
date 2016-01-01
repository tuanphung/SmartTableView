//
//  EventTableViewCell.swift
//  goru
//
//  Created by Tuan Phung on 12/28/15.
//  Copyright © 2015 Silicon Straits. All rights reserved.
//

import Foundation
import HCSStarRatingView

class EventTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var topImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starRatingView: HCSStarRatingView!
    @IBOutlet weak var numRatingLabel: UILabel!
    
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.selectionStyle = .None
        self.topImageView.sd_cancelCurrentImageLoad()
    }
}

// MARK: TableViewCell Configurations
extension EventTableViewCell: StatefulTableViewCellProtocol {
    static func height(model: AnyObject) -> CGFloat {
        return 280
    }
    
    func configureCell(model: AnyObject) {
        if let event = model as? Event {
            self.topImageView.sd_setImageWithURL(NSURL(string: event.imageLarge), placeholderImage: UIImage(named: "meshup-background-placeholder"))
            
            self.titleLabel.text = event.name
            self.starRatingView.value = CGFloat(event.rating)
            
            self.numRatingLabel.text = "\(event.numRating) review" + (event.numRating > 1 ? "s" : "")
            
            self.startDateLabel.text = "-"
            if let startDate = event.dateFrom {
                self.startDateLabel.text = "\(startDate.ex_toString("DDD, MMM dd, yyyy"))"
            }

            self.endDateLabel.text = "-"
            if let endDate = event.dateTo {
                self.endDateLabel.text = "\(endDate.ex_toString("DDD, MMM dd, yyyy"))"
            }
        }
    }
}