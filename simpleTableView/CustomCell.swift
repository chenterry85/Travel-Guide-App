//
//  CustomCell.swift
//  simpleTableView
//
//  Created by Terry Chen on 2020/2/6.
//  Copyright © 2020 Terry Chen. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet var cityLabel:UILabel!
    @IBOutlet var countryLabel:UILabel!
    @IBOutlet var continentLabel:UILabel!
    @IBOutlet var cityImage:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
