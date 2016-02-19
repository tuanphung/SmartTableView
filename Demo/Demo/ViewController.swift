//
// Copyright (c) 2016 PHUNG ANH TUAN. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import ATTableView
import SwiftyJSON

enum ModelType: Int {
    case Restaurant, Hotel, Tip, Event
}

class ViewController: UIViewController {
    @IBOutlet var tableView: ATTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ATTableView"
        
        self.tableView.register(RestaurantTableViewCell.self)
        self.tableView.register(HotelTableViewCell.self)
        self.tableView.register(EventTableViewCell.self)
        self.tableView.register(TipTableViewCell.self)

        self.tableView.addObjects(self.generateModels())
        
        self.tableView.onDidSelectItem = { item in
            // Do something here.
            print(item)
        }
    }
    
    // Load sample data from local json file.
    func generateModels() -> [AnyObject] {
        var models = [AnyObject]()
        
        let path = NSBundle.mainBundle().pathForResource("data", ofType: "json")
        let data = NSData(contentsOfFile: path!)!
        let json = JSON(data: data)
        
        for (_, subJson) in json {
            if let type = ModelType(rawValue: subJson["type"].intValue) {
                switch type {
                case .Restaurant:
                    models.append(Restaurant(json: subJson))
                case .Hotel:
                    models.append(Hotel(json: subJson))
                case .Tip:
                    models.append(Tip(json: subJson))
                case .Event:
                    models.append(Event(json: subJson))
                }
            }
        }
        
        return models
    }

}

