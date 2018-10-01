//
//  AircraftDetailsTableViewCell.swift
//  WeightAndLevel
//
//  Created by Reymund on 18/08/2018.
//  Copyright © 2018 ReymundoPanaguiton. All rights reserved.
//

import UIKit

class AircraftDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageAC: UIImageView!
    @IBOutlet weak var nameAC: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
