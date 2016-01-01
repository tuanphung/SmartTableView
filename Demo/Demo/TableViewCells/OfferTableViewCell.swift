//
//  GoLocalListTableViewCell.swift
//  goru
//
//  Created by Pham Ba Tho on 18/11/15.
//  Copyright © 2015 Silicon Straits. All rights reserved.
//

import UIKit

class OfferTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateExpiresLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.selectionStyle = .None
        self.topImageView.sd_cancelCurrentImageLoad()
    }
}

// MARK: TableViewCell Configurations
extension OfferTableViewCell: StatefulTableViewCellProtocol {
    func configureCell(model: AnyObject) {
        guard let offer = model as? Offer else { return }
        
        self.titleLabel.text = offer.name
        self.descriptionLabel.text = offer.description
        
        if let expiredDate = offer.expiredDate {
            self.dateExpiresLabel.text = expiredDate.ex_toString("MMM dd, yyyy")
        }
        
        self.topImageView.sd_setImageWithURL(NSURL(string: offer.image), placeholderImage: UIImage(named: "meshup-background-placeholder"))
    }
}