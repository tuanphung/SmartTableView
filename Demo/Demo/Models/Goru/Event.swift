//
//  Event.swift
//  goru
//
//  Created by Tuan Phung on 12/28/15.
//  Copyright © 2015 Silicon Straits. All rights reserved.
//

import HCSStarRatingView

class Event {
    // Properties
    var name: String = ""
    var images = [String]()
    var startDate: NSDate?
    var endDate: NSDate?
    
    var imageMedium: String = ""
    var imageLarge: String = ""
    var numRating: Int = 0
    var isFavourited: Bool = false
    var dateFrom: NSDate?
    var dateTo: NSDate?
    var rating: Double = 0
    var shortDesctiption: String?
}