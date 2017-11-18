//
//  Gate.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 3/18/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation


/*
    Trying to implement a form of Role-Based Access Control (RBAC).
    This class will handle the types of 'gates' (points where access is checked),
    and answer the 'can I come in?' question.
*/

// to show off protocol composition, need methods and/or classes that
// conform to -- Accessible AND Discount-able?  AND Skip-able?


/*
 In this attempt at Role-Based Access (and discounts, and privilidges), 
 I am making the point-of-decision be the location (ride, food vendor, etc.).
 The location will 'know' which roles get what benefits.
 */


enum GateType {
    case rideRides
    case amusement
    case foodVendor
    case merchVendor
    case kitchen
    case rideControl
    case maintenance
    case office
}

enum ProductType {
    case food
    case merchandise
}

enum GateError: Error {
    case unknownGateType
    
}

var rides = [Ride]()  // only exists to for-loop through, generating passes for test purposes

 class Gate {
    let gateID: Int
    let gateType: GateType
    let gateName: String

    init(gateID: Int, gateType: GateType, gateName: String) {
        self.gateID = gateID
        self.gateType = gateType
        self.gateName = gateName
    }
}
