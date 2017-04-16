//
//  Ride.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 4/14/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

class Ride: Gate {

    var ageRestricted: Bool
        
    init(gateID: Int, gateType: GateType, gateName: String, ageRestricted: Bool) {
            self.ageRestricted = ageRestricted
            super.init(gateID: gateID, gateType: gateType, gateName: gateName)
    }
}
