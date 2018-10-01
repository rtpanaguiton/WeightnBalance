//
//  WeightDetail.swift
//  wBal
//
//  Created by Reymund on 30/09/2018.
//  Copyright © 2018 ReymundoPanaguiton. All rights reserved.
//

import Foundation
import RealmSwift

class WeightDetail: Object {
    
    @objc dynamic var pilotWeight = 0.0
    @objc dynamic var coPilotWeight = 0.0
    @objc dynamic var pax1Weight = 0.0
    @objc dynamic var pax2Weight = 0.0
    @objc dynamic var pax3Weight = 0.0
    @objc dynamic var baggageWeight = 0.0
    @objc dynamic var fuelWeight = 0.0
 
    
}
