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

public protocol ATTableViewCellProtocol: NSObjectProtocol {
    typealias ModelType
    
    // Optional, default is ClassName
    static func reuseIdentifier() -> String
    
    // Optional, default is ClassName
    static func nibName() -> String?
    
    // Draft behaviour
    // In case a model is displayed by multiple Cells, use pairCode to match model and cell.
    // Paircode only is checked if model have a paircode setup.
    // If paircode is not setup in model, just need to check mapping class type.
    // If paircode is setup in model, and it's same to cell's paircode, it's matched. Otherwise, cell will not pick up that model to display.
    static func pairCode() -> Int?
    
    // Optional, default is `UITableViewAutomaticDimension`
    static func height(model: ModelType) -> CGFloat
    
    // Define how to map properties of model to UI.
    // This method must be implemented.
    func configureCell(model: ModelType)
}

public extension ATTableViewCellProtocol {
    static func reuseIdentifier() -> String { return "\(self)" }
    
    static func nibName() -> String? { return "\(self)" }
    
    static func nib() -> UINib? {
        guard let nibName = nibName() else { return nil }
        
        return UINib(nibName: nibName, bundle: nil)
    }
    
    static func pairCode() -> Int? { return nil }
    
    static  func height(model: ModelType) -> CGFloat { return UITableViewAutomaticDimension }
}

public extension UITableViewCell {
    public func fireSignal(identifier: String, associatedObject: Any?) {
        var view = self.superview
        while (view != nil && view!.isKindOfClass(ATTableView.self) == false) {
            view = view?.superview
        }

        if let tableView = view as? ATTableView {
            tableView.fireSignal(ATSignal(identifider: identifier, associatedObject: associatedObject))
        }
    }
}
