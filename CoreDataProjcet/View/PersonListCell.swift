//
//  PersonListCell.swift
//  CoreDataProjcet
//
//  Created by Bhabani on 16/06/20.
//  Copyright © 2020 Bhabani. All rights reserved.
//

import UIKit

class PersonListCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected == true ? AccessoryType.checkmark : AccessoryType.none
        // Configure the view for the selected state
    }

}
