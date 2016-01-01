//
//  Event.swift
//  goru
//
//  Created by Tuan Phung on 12/28/15.
//  Copyright © 2015 Silicon Straits. All rights reserved.
//

import Foundation
import SwiftyJSON

class Event {
    // Properties
    var name: String = ""
    var imageName: String = ""
    var numberOfReviews: Int = 0
    var rating: Double = 0
    var startDate: NSDate?
    var endDate: NSDate?
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.imageName = json["imageName"].stringValue
        self.rating = json["rating"].doubleValue
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.dateFormat = "yyyyMMdd"
        
        self.startDate = dateFormatter.dateFromString(json["startDate"].stringValue)
        self.endDate = dateFormatter.dateFromString(json["endDate"].stringValue)
    }
}