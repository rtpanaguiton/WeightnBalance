//
//  TableViewCell.swift
//  WeightAndLevel
//
//  Created by Reymund on 05/09/2018.
//  Copyright © 2018 ReymundoPanaguiton. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var aircraftImage: UIImageView! 
    @IBOutlet weak var registrationNumber: UILabel!
    @IBOutlet weak var aircraftType: UILabel!
    var actualAircraftWeight = 1007.0
    var actualAircraftCG = 1.456
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
    
}
