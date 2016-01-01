//
//  Stay.swift
//  goru
//
//  Created by Tuan Phung on 12/11/15.
//  Copyright © 2015 Silicon Straits. All rights reserved.
//

import Foundation
import SwiftyJSON

class Hotel {
    // Properties
    var name: String = ""
    var imageName: String = ""
    var price: Double = 0
    var userRating: Double = 0
    var rating: Double = 0
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.imageName = json["imageName"].stringValue
        self.price = json["price"].doubleValue
        self.userRating = json["userRating"].doubleValue
        self.rating = json["rating"].doubleValue
    }
}