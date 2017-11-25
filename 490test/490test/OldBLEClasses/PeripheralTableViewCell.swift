//
//  PeripheralTableViewCell.swift
//  490test
//
//  Created by Nicolas Spragg on 2017-11-17.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation
import UIKit

class PeripheralTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rssiLabel: UILabel!
    @IBOutlet weak var peripheralLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
