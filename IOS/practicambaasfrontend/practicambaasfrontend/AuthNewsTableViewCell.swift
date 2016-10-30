//
//  AuthNewsTableViewCell.swift
//  practicambaasfrontend
//
//  Created by Alma Martinez on 30/10/16.
//  Copyright © 2016 Alma Martinez. All rights reserved.
//

import UIKit

class AuthNewsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var titleNews: UILabel!
    
    @IBOutlet weak var valuationNews: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
