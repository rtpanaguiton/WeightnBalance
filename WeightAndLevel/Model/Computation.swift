//
//  Computation.swift
//  WeightAndLevel
//
//  Created by Reymund on 15/08/2018.
//  Copyright © 2018 ReymundoPanaguiton. All rights reserved.
//

import Foundation

class Computation {
    
    var pilotWeight = 0.0
    var coPilotWeight = 0.0
    var pax1Weight = 0.0
    var pax2Weight = 0.0
    var pax3Weight = 0.0
    var fuelWeight = 0.0
    var baggageWeight = 0.0
    var aircraftMomentArm = 0.0
    
    var aircraftWeight: Double
    
    init(aircraftWeight: Double, aircraftCG: Double) {
        self.aircraftWeight = aircraftWeight
        aircraftMomentArm = aircraftCG
    }
    
    struct momentArm {
        static let pilot = 2.35
        static let pax = 3.10
        static let baggage = 4.75
        static let fuel = 4.10
    }
    private func computeForPilotsWeight() -> Double {
        return pilotWeight + coPilotWeight
    }
    
    private func computeMomentPilots() -> Double {
        return computeForPilotsWeight() * momentArm.pilot
    }
    private func computeMomentOfPax() -> Double {
        return computeForPaxWeights() * momentArm.pax
    }
    
    private func computeForMomentOfFuel() -> Double {
        let moment = fuelWeight * momentArm.fuel
        return moment
    }
    
    private func computeMomentOfArcraft() -> Double {
        let moment = aircraftWeight * aircraftMomentArm
        return moment
    }
    
    func computeForCenterOfGravity() -> Double {
        let totalMoment = computeMomentOfPax() + computeMomentPilots() + computeMomentOfArcraft() + computeForMomentOfFuel()
        return totalMoment / computeForTotalWeight()
    }
    
    private func computeForPaxWeights() -> Double {
        return pax1Weight + pax2Weight + pax3Weight
    }
    
    func computeForTotalWeight() -> Double {
        return computeForPilotsWeight() + computeForPaxWeights() + fuelWeight + aircraftWeight + baggageWeight
    }
}
