//
//  PermissionsAndBenefits.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 4/11/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

class PermissionsAndBenefits {

let guestRolesDiscount:[ProductType:[GuestType:Int]] = [
    .food:
        [.vIP:10, .senior:10, .season:10],
    .merchandise:
        [.vIP:20, .senior:10, .season:20]
]

let guestRolesSkipPrivilege:[GateType:[GuestType]] = [
    .rideRides:[.vIP]
]


// sticking with "it's the location that knows the benefit", Food (vendor) and
// Merchandice (vendor) are first decision, then the role.

let workerRolesDiscount:[ProductType:[WorkerType:Int]] = [
    .food:[
        .hourlyFoodServices:15,
        .hourlyRideServices:15,
        .hourlyMaintenance:15,
        .manager:25],
    .merchandise:[
        .hourlyFoodServices:25,
        .hourlyRideServices:25,
        .hourlyMaintenance:25,
        .manager:25]
]

func accessPermitted(requestor: Entrant, gate: Gate) -> Bool {
    var permitted = false
    
     if requestor is Guests {
        let guestRequestor = requestor as! Guests
        permitted = canAccess(guestType: guestRequestor.guestType, gateType: gate.gateType)
        if gate is Ride {
            let ride = gate as! Ride
            if guestRequestor.guestType == .freeChild && ride.ageRestricted {
                 permitted = false
            }
        }
     } else if requestor is Contractors {
        let contractRequestor = requestor as! Contractors
        permitted = canAccess(projectNumber: String(contractRequestor.projectNumber), gateType: gate.gateType)
     } else if requestor is VendorStaff {
        let vendorRequestor = requestor as! VendorStaff
        permitted = canAccess(companyName: vendorRequestor.companyName, gateType: gate.gateType)
     } else if requestor is Workers {
         let workerRequestor = requestor as! Workers
         permitted = canAccess(workerType: workerRequestor.workerType, gateType: gate.gateType)
     }
     return permitted
}


func discountAvailable(requestor: Entrant, product: ProductType) -> Int {
    
    switch (product) {
    case .food:
        if (requestor is Guests) {
            let guestRequestor = requestor as! Guests
            if let discount = guestRolesDiscount[.food]?[guestRequestor.guestType] {
                return discount
            }
        } else if requestor is Workers {
            let workerRequestor = requestor as! Workers
            
            if let discount = workerRolesDiscount[.food]?[workerRequestor.workerType] {
                return discount
            }
        }
        
    case .merchandise:
        if (requestor is Guests) {
            let guestRequestor = requestor as! Guests
            
            if let discount = guestRolesDiscount[.merchandise]?[guestRequestor.guestType] {
                return discount
            }
            
        } else if requestor is Workers {
            let workerRequestor = requestor as! Workers
            
            if let discount = workerRolesDiscount[.merchandise]?[workerRequestor.workerType] {
                return discount
            }
        }
    }
    return 0
}

func canSkipLine(requestor: Entrant, gateType: GateType) -> Bool {
    var permitted = false
    if (requestor is Guests) {
        let guestRequestor = requestor as! Guests
        permitted = (guestRolesSkipPrivilege[gateType]!.contains(guestRequestor.guestType))
    }
    return permitted
}


func canAccess(guestType: GuestType, gateType: GateType) -> Bool {
    if let access = guestRules[guestType]?[gateType] {
        return access
    } else {
        print("no access rule for \(guestType) at \(gateType)")
        return false
    }
}

func canAccess(workerType: WorkerType, gateType: GateType) -> Bool {
    if let access = workerRules[workerType]?[gateType] {
        return access
    } else {
        print("no access rule for \(workerType) at \(gateType)")
        return false
    }
}

func canAccess(companyName: String, gateType: GateType) -> Bool {
    if let access = vendorStaffRules[companyName]?[gateType] {
        return access
    } else {
        print("no access rule for VendorStaff from \(companyName) at \(gateType)")
        return false
    }
}

func canAccess(projectNumber: String, gateType: GateType) -> Bool {
    if let access = contractorRules[projectNumber]?[gateType] {
        return access
    } else {
        print("no access rule for Contractors on Project # \(projectNumber) at \(gateType)")
        return false
    }
}
    
}
