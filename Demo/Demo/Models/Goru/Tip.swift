//
//  Tip.swift
//  goru
//
//  Created by Tuan Phung on 12/9/15.
//  Copyright © 2015 Silicon Straits. All rights reserved.
//

import Foundation
import SwiftyJSON

class Tip {
    // Properties
    var name: String = ""
    
    init(json: JSON) {
        self.name = json["name"].stringValue
    }
}