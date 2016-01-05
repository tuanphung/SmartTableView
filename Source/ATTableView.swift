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

typealias Mapping = (heightBlock:((model: AnyObject) -> CGFloat), configureCellBlock: (cell: UITableViewCell, model: AnyObject) -> (), identifier: String, modelType: Any.Type)

public class ATTableView: UITableView {
    public var defaultSection = ATTableViewSection()
    
    public var onDidSelectItem: ((item: AnyObject) -> ())?
    
    // Abstract the way to implement LoadMore feature.
    // Under implementation.
    public var shouldLoadMore: Bool = false
    public var onLoadMore: (() -> ())?
    public func loadMoreDidCompleteWithItems(items: [AnyObject]) {
        self.shouldLoadMore = (items.count == 0) ? false : true
        self.addItems(items)
    }
    
    // Keep referrence to models, encapsulated into LazyTableViewSection.
    private var source = [ATTableViewSection]()
    
    // Keep all setup for each CellType registered.
    private var mappings = [Mapping]()
    
    // Find registed cell type that accept model.
    private func mappingForModel(model: AnyObject) -> Mapping? {
        for mapping in mappings {
            if mapping.modelType == model.dynamicType {
                return mapping
            }
        }
        
        return nil
    }

    // Initializers
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialize()
    }
    
    public func initialize() {
        self.dataSource = self
        self.delegate = self
        
        // Auto Setup first section
        self.source.append(defaultSection)
    }

    public func addSection(section: ATTableViewSection, atIndex index: Int) {
        self.source.insert(section, atIndex: index)
    }
    
    public func addSection(section: ATTableViewSection) {
        self.source.append(section)
        
        // Render data
        self.reloadData()
    }
    
    public func addItems(items: [AnyObject]?, section: Int) {
        let section = self.source[section]
        section.addItems(items)
        
        // Render data
        self.reloadData()
    }
    
    public func addItems(items: [AnyObject]?) {
        self.addItems(items, section: 0)
    }
    
    // Register cell, setup some code blocks and store them to execute later.
    public func register<T: ATTableViewCellProtocol>(cellType: T.Type) {
        let identifier = cellType.reuseIdentifier()
        
        guard let _ = self.dequeueReusableCellWithIdentifier(identifier) else {
            // Create block code to execute class method `height:`
            // This block will be executed in `tableView:heightForRowAtIndexPath:`
            let heightBlock = { (model: AnyObject) -> CGFloat in
                if let model = model as? T.ModelType {
                    return cellType.height(model)
                }
                return 0
            }
            
            // Create block code to execute method `configureCell:` of cell
            // This block will be executed in `tableView:cellForRowAtIndexPath:`
            let configureCellBlock = { (cell: UITableViewCell, model: AnyObject) in
                if let cell = cell as? T, let model = model as? T.ModelType {
                    cell.configureCell(model)
                }
            }
            
            self.mappings.append(Mapping(heightBlock, configureCellBlock, identifier, T.ModelType.self))
            
            if let nibName = cellType.nibName() {
                self.registerNib(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: identifier)
            }
            else {
                self.registerClass(cellType, forCellReuseIdentifier: identifier)
            }
            return
        }
    }
    
    public func clearAll() {
        for section in self.source {
            section.clear()
        }
        
        self.reloadData()
    }
    
    public func clearItemsAtSection(section: Int) {
        self.source[section].clear()
        
        self.reloadData()
    }
    
    public override func reloadData() {
        
        super.reloadData()
    }
}

extension ATTableView: UITableViewDataSource, UITableViewDelegate {
    // Configure sections
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.source.count
    }
    
    // Configure header for section
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.source[section].headerTitle
    }
    
    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.source[section].customHeaderView?(section: section)
    }
    
    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.source[section].headerHeight
    }
    
    // Configure footer for section
    public func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.source[section].footerTitle
    }
    
    public func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.source[section].customFooterView?(section: section)
    }
    
    public func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.source[section].footerHeight
    }
    
    // Configure cells
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.source[section].items.count
    }
    
    public func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if shouldLoadMore {
            // For now, just apply load more for the first section
            if indexPath.section == 0 && indexPath.row == defaultSection.items.count - 1 {
                self.onLoadMore?()
            }
        }
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let model: AnyObject = self.source[indexPath.section].items[indexPath.row]
        
        if let mapping = self.mappingForModel(model) {
            let cell = tableView.dequeueReusableCellWithIdentifier(mapping.identifier, forIndexPath: indexPath)
            mapping.configureCellBlock(cell: cell, model: model)
            return cell

        }
        return UITableViewCell()
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let model: AnyObject = self.source[indexPath.section].items[indexPath.row]
        
        if let mapping = self.mappingForModel(model) {
            return mapping.heightBlock(model: model)
        }
        
        return 0
    }
    
    // Handle actions
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.onDidSelectItem?(item: self.source[indexPath.section].items[indexPath.row])
    }
}