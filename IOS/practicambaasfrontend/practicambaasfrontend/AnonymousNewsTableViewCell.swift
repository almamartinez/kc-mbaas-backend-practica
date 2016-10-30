//
//  AnonymousNewsTableViewCell.swift
//  practicambaasfrontend
//
//  Created by Alma Martinez on 31/10/16.
//  Copyright © 2016 Alma Martinez. All rights reserved.
//

import UIKit

class AnonymousNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var valuationLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
