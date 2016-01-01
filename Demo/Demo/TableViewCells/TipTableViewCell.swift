//
//  HomeMeshupListCell.swift
//  goru
//
//  Created by Pham Ba Tho on 12/4/15.
//  Copyright © 2015 Silicon Straits. All rights reserved.
//

import UIKit
import LazyTableView

class TipTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.selectionStyle = .None
    }
}

// MARK: TableViewCell Configurations
extension TipTableViewCell: LazyTableViewCellProtocol {
    static func acceptableModelTypes() -> [AnyClass] {
        return [Tip.self]
    }
    
    static func height(model: AnyObject) -> CGFloat {
        return 60
    }
    
    func configureCell(model: AnyObject) {
        if let tip = model as? Tip {
            self.nameLabel.text = tip.name
        }
    }
}