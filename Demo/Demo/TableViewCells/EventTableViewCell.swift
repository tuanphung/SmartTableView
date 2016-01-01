//
//  EventTableViewCell.swift
//  goru
//
//  Created by Tuan Phung on 12/28/15.
//  Copyright © 2015 Silicon Straits. All rights reserved.
//

import Foundation
import LazyTableView
import HCSStarRatingView

class EventTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var topImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starRatingView: HCSStarRatingView!
    
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.selectionStyle = .None
    }
}

// MARK: TableViewCell Configurations
extension EventTableViewCell: LazyTableViewCellProtocol {
    static func acceptableModelTypes() -> [AnyClass] {
        return [Event.self]
    }
    
    static func height(model: AnyObject) -> CGFloat {
        return 265
    }
    
    func configureCell(model: AnyObject) {
        if let event = model as? Event {
            self.topImageView.image = UIImage(named: event.imageName)
            
            self.titleLabel.text = event.name
            self.starRatingView.value = CGFloat(event.rating)
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
            dateFormatter.dateFormat = "DDD, MMM dd, yyyy"
            
            self.startDateLabel.text = "-"
            if let startDate = event.startDate {
                self.startDateLabel.text = "\(dateFormatter.stringFromDate(startDate))"
            }

            self.endDateLabel.text = "-"
            if let endDate = event.startDate {
                self.endDateLabel.text = "\(dateFormatter.stringFromDate(endDate))"
            }
        }
    }
}