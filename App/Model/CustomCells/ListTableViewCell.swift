//
//  ListTableViewCell.swift
//  App
//
//  Created by Qwesys on 01/11/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var btnOffer: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnOffer.setCornerRadius(radius: btnOffer.frame.size.height/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
