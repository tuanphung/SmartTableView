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

public protocol LazyTableViewCellProtocol: NSObjectProtocol {
    static func reuseIdentifier() -> String
    
    static func nibName() -> String?
    
    static func nib() -> UINib?
    
    static func height(model: AnyObject) -> CGFloat
    
    // Draft behaviour
    // In case a model is displayed by multiple Cells, use pairCode to match model and cell.
    // Paircode only is checked if model have a paircode setup.
    // If paircode is not setup in model, just need to check mapping class type.
    // If paircode is setup in model, and it's same to cell's paircode, it's matched. Otherwise, cell will not pick up that model to display.
    static func pairCode() -> Int?
    
    // Define what class of model that Cell can display. It will ignore all models that type is not in list.
    // This method is required overriding.
    static func acceptableModelTypes() -> [AnyClass]
    
    // Define how to map properties of model to UI.
    // This method is required overriding.
    func configureCell(model: AnyObject)
}

public extension LazyTableViewCellProtocol {
    static func reuseIdentifier() -> String { return "\(self)" }
    
    static func nibName() -> String? { return "\(self)" }
    
    static func nib() -> UINib? {
        guard let nibName = nibName() else { return nil }
        
        return UINib(nibName: nibName, bundle: nil)
    }
    
    static func pairCode() -> Int? { return nil }
    
    static func height(model: AnyObject) -> CGFloat { return UITableViewAutomaticDimension }
}
