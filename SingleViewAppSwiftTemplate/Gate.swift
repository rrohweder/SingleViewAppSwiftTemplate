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
    case Amusement
    case Kitchen
    case RideControl
    case Maintenance
    case Office
}

enum ProductType {
    case Food
    case Merchandise
}

enum GateError: Error {
    case unknownGateType
    
}

class Gate {
    
    var gateType: GateType
    
    let guestRolesAccess:[GateType: [GuestType]] = [
    .Amusement:[.Classic,.VIP,.FreeChild],
    ]
    
    let guestRolesDiscount:[ProductType:[GuestType:Int]] = [
    .Food:
        [.VIP:10],
    .Merchandise:
        [.VIP:20]
    ]
    
    let guestRolesSkipPrivilege:[GateType:[GuestType]] = [
        .Amusement:[.VIP]
    ]
    
    let workerRolesAccess:[GateType: [WorkerType]] = [
        .Amusement:[.HourlyFoodServices, .HourlyRideServices, .HourlyMaintenance, .Manager],
        .Kitchen:[.HourlyFoodServices, .HourlyMaintenance, .Manager],
        .RideControl:[.HourlyRideServices,.HourlyMaintenance,.Manager],
        .Maintenance:[.HourlyMaintenance, .Manager],
        .Office:[.Manager]
    ]
    
    // sticking with "it's the location that knows the benefit", Food (vendor) and
    // Merchandice (vendor) are first decision, then the role.
    
    let workerRolesDiscount:[ProductType:[WorkerType:Int]] = [
        .Food:[
            .HourlyFoodServices:15,
            .HourlyRideServices:15,
            .HourlyMaintenance:15,
            .Manager:25],
        .Merchandise:[
            .HourlyFoodServices:25,
            .HourlyRideServices:25,
            .HourlyMaintenance:25,
            .Manager:25]
    ]
    
    // not needed with intial input data
    let workerRolesSkipPrivilege:[GateType:[WorkerType]] = [
        .Amusement:[]
    ]
    
    init(gateType: GateType) {
        self.gateType = gateType
    }
    
    // should the function be "func swipe(requestor: Entrant, gate: GateType,
    // &accessAnswer:Bool, &discountAmount: int, &skipLine: Bool) -> Bool
    // and then call generatePass() ?
    
    func AccessPermitted(requestor: Entrant, gateType: GateType) -> Bool {
        var permitted = false
        switch (gateType) {
            case .Amusement:
                if (requestor is Guest) {
                    let guestRequestor = requestor as! Guest
                    if let isPermitted = (guestRolesAccess[.Amusement]?.contains(guestRequestor.guestType)) {
                        print("\(guestRequestor.guestType), access = \(permitted)")
                        permitted = isPermitted
                    }
                } else if requestor is Worker {
                    let workerRequestor = requestor as! Worker
                    if let isPermitted = (workerRolesAccess[.Amusement]?.contains(workerRequestor.workerType)) {
                        print("\(workerRequestor.workerType), access = \(permitted)")
                        permitted = isPermitted
                    }
                }

            case .Kitchen:
                if (requestor is Guest) {
                    let guestRequestor = requestor as! Guest
                    if let isPermitted = (guestRolesAccess[.Kitchen]?.contains(guestRequestor.guestType)) {
                        print("\(guestRequestor.guestType), access = \(permitted)")
                        permitted = isPermitted
                    }
                } else if requestor is Worker {
                    let workerRequestor = requestor as! Worker
                    if let isPermitted = (workerRolesAccess[.Kitchen]?.contains(workerRequestor.workerType)) {
                        print("\(workerRequestor.workerType), access = \(permitted)")
                        permitted = isPermitted
                    }
                }
            
            case .Maintenance:
                if (requestor is Guest) {
                    let guestRequestor = requestor as! Guest
                    if let isPermitted = (guestRolesAccess[.Maintenance]?.contains(guestRequestor.guestType)) {
                        print("\(guestRequestor.guestType), access = \(permitted)")
                        permitted = isPermitted
                    }
                } else if requestor is Worker {
                    let workerRequestor = requestor as! Worker
                    if let isPermitted = (workerRolesAccess[.Maintenance]?.contains(workerRequestor.workerType)) {
                        print("\(workerRequestor.workerType), access = \(permitted)")
                        permitted = isPermitted
                    }
                }
            
            case .Office:
                if (requestor is Guest) {
                    let guestRequestor = requestor as! Guest
                    if let isPermitted = (guestRolesAccess[.Office]?.contains(guestRequestor.guestType)) {
                        print("\(guestRequestor.guestType), access = \(permitted)")
                        permitted = isPermitted
                    }
                } else if requestor is Worker {
                    let workerRequestor = requestor as! Worker
                    if let isPermitted = (workerRolesAccess[.Office]?.contains(workerRequestor.workerType)) {
                        print("\(workerRequestor.workerType), access = \(permitted)")
                        permitted = isPermitted
                    }
                }
            
            case .RideControl: print("\(gateType), access=\(permitted)")
                if (requestor is Guest) {
                    let guestRequestor = requestor as! Guest
                    if let isPermitted = (guestRolesAccess[.RideControl]?.contains(guestRequestor.guestType)) {
                        print("\(guestRequestor.guestType), access = \(permitted)")
                        permitted = isPermitted
                    }
                } else if requestor is Worker {
                    let workerRequestor = requestor as! Worker
                    if let isPermitted = (workerRolesAccess[.RideControl]?.contains(workerRequestor.workerType)) {
                        print("\(workerRequestor.workerType), access = \(permitted)")
                        permitted = isPermitted
                    }
                }
        }
        return permitted
    }
    
    func discountAvailable(requestor: Entrant, product: ProductType) -> Int {

        switch (product) {
            case .Food:
                if (requestor is Guest) {
                    let guestRequestor = requestor as! Guest
                    switch guestRequestor.guestType {
                        case GuestType.Classic:
                            if let discount = guestRolesDiscount[.Food]?[guestRequestor.guestType] {
                                print("\(guestRequestor.guestType) discount= \(discount)")
                                return discount
                            }
                        case GuestType.VIP:
                            if let discount = guestRolesDiscount[.Food]?[guestRequestor.guestType] {
                                print("\(guestRequestor.guestType) discount= \(discount)")
                                return discount
                            }
                        case GuestType.FreeChild:
                            if let discount = guestRolesDiscount[.Food]?[guestRequestor.guestType] {
                                print("\(guestRequestor.guestType) discount= \(discount)")
                                return discount
                            }
                    }
                } else if requestor is Worker {
                    let workerRequestor = requestor as! Worker

                    if let discount = workerRolesDiscount[.Food]?[workerRequestor.workerType] {
                        print("\(workerRequestor.workerType) discount= \(discount)")
                        return discount
                    }
                }
            
        case .Merchandise:
            if (requestor is Guest) {
                let guestRequestor = requestor as! Guest
                
                if let discount = guestRolesDiscount[.Merchandise]?[guestRequestor.guestType] {
                    print("\(guestRequestor.guestType) discount= \(discount)")
                    return discount
                }
                
            } else if requestor is Worker {
                let workerRequestor = requestor as! Worker

                if let discount = workerRolesDiscount[.Merchandise]?[workerRequestor.workerType] {
                    print("\(workerRequestor.workerType) discount= \(discount)")
                    return discount
                }
            }
        }
        return 0
    }

    func guestCanSkipLine(requestor: Entrant, gateType: GateType) -> Bool {
        var permitted = false
        if (requestor is Guest) {
            let guestRequestor = requestor as! Guest
            permitted = (guestRolesSkipPrivilege[gateType]!.contains(guestRequestor.guestType))
            print("\(guestRequestor.guestType), skip permitted? = \(permitted)")
        }
        return permitted
    }
    
    // I must admit - why not just do this?
    //  entrantsAllowed = accessDictionary[gate]
    //    accessAnswer = entrantsAllowed.contains(requestor_type)
    // if let discount = discountAvailable[requestor_type] {
    //    discountAmount = discount
    // if let skip = skipLine[requestor_type] {
    //    skipLine = skip
    // if nothing puked, return access, discount, and skip answers.

}
