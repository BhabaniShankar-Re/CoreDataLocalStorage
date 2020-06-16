//
//  DeviceListTableViewCell.swift
//  CoreDataProjcet
//
//  Created by Bhabani on 13/06/20.
//  Copyright © 2020 Bhabani. All rights reserved.
//

import UIKit

class DeviceListTableViewCell: UITableViewCell {
    @IBOutlet weak var deviceNameLabel: UILabel!
    
    @IBOutlet weak var ownerNameLabel: UILabel!
    

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
