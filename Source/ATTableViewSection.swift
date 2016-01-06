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

public class ATTableViewSection {
    let DefaultHeaderHeight: CGFloat = 22
    let DefaultFooterHeight: CGFloat = 22
    
    var headerTitle: String? {
        didSet {
            // Set default header height in case title != nil and headerHeight is not set.
            if let title = self.headerTitle where title != "" && self.headerHeight == 0 {
                self.headerHeight = DefaultHeaderHeight
            }
        }
    }
    
    var headerHeight: CGFloat = 0.0
    var customHeaderView: ((section: Int) -> UIView?)?
    
    var footerTitle: String? {
        didSet {
            // Set default footer height in case title != nil and footerHeight is not set.
            if let title = self.footerTitle where title != "" && self.footerHeight == 0 {
                self.footerHeight = DefaultFooterHeight
            }
        }
    }
        
    var footerHeight: CGFloat = 0.0
    var customFooterView: ((section: Int) -> UIView?)?
    
    var items: [Any]
    
    init(headerTitle: String?, footerTitle: String?, items: [Any]) {
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
        self.items = items
    }
    
    convenience init() {
        self.init(headerTitle: nil, footerTitle: nil, items: [])
    }
    
    convenience init(items: [Any]) {
        self.init(headerTitle: nil, footerTitle: nil, items: items)
    }
    
    func addItems(newItems: [Any]?) {
        guard let newItems = newItems else { return }
        
        self.items.appendContentsOf(newItems)
    }
    
    func clear() {
        self.items.removeAll()
    }
}
