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
    
    let gateType: GateType
    
    let guestRolesAccess:[GateType: [GuestType]] = [
    .Amusement:[.Classic,.VIP,.FreeChild],
    ]
    
    let guestRolesDiscount:[ProductType:[GuestType:Int]] = [
    .Food:[.VIP:10],
    .Merchandise:[.VIP:20]
    ]
    
    let guestRolesSkipPrivilege:[GateType:[GuestType]] = [
        .Amusement:[.VIP]
    ]
    
    let workerRolesAccess:[GateType: [EmployeeType]] = [
        .Amusement:[.HourlyFoodServices, .HourlyRideServices, .HourlyMaintenance, .Manager
        ]
    ]
    
    // sticking with "it's the location that knows the benefit", Food (vendor) and
    // Merchandice (vendor) are first decision, then the role.
    
    let workerRolesDiscount:[ProductType:[EmployeeType:Int]] = [
        .Food:[.HourlyFoodServices:15,
            .HourlyRideServices:15,
            .HourlyMaintenance:15,
            .Manager:15],
        .Merchandise:[.HourlyFoodServices:25, .HourlyRideServices:25, .HourlyMaintenance:25, .Manager:25]
    ]
    
    // not needed with intial input data
    let workerRolesSkipPrivilege:[GateType:[EmployeeType]] = [
        .Amusement:[]
    ]
    
    init(gateType: GateType) {
        self.gateType = gateType
    }
    
   // should the function be "func swipe(requestor: Entrant, gate: GateType, &accessAnswer:Bool, &discountAmount: int, &skipLine: Bool) -> Bool
    // and then call generatePass()
    
    func AccessPermitted(requestor: Entrant, gate: GateType) -> Bool {
        
        if (requestor is Guest) {
            let guestRequestor = requestor as! Guest
            
            switch guestRequestor.guestType {
                case GuestType.Classic: print("Classic")
                case GuestType.VIP: print("VIP")
                case GuestType.FreeChild: print("Free Child")
            }
            
        } else if requestor is Employee {
            let employeeRequestor = requestor as! Employee
            switch employeeRequestor.employeeType {
                case EmployeeType.HourlyFoodServices:
                    print("Hourly, Food Services")
                case EmployeeType.HourlyRideServices: print("Hourly, Ride Services")
                case EmployeeType.HourlyMaintenance: print("Hourly, Maintenance")
                case EmployeeType.Manager: print("Manager")
            }
        }
        return true
    }
    
    func discountAvailable(requestor: Entrant, product: ProductType) -> Double {

        switch (product) {
            case .Food:
                if (requestor is Guest) {
                    let guestRequestor = requestor as! Guest
                    let discount = guestRolesDiscount[requestor.guestType]
                    switch guestRequestor.guestType {
                        case GuestType.Classic: print("Classic, discount=\(discount)")
                        case GuestType.VIP: print("VIP")
                        case GuestType.FreeChild: print("Free Child")
                    }
                
                    } else if requestor is Employee {
                    let employeeRequestor = requestor as! Employee
                    switch employeeRequestor.employeeType {
                        case EmployeeType.HourlyFoodServices: print("Hourly, Food Services")
                        case EmployeeType.HourlyRideServices: print("Hourly, Ride Services")
                        case EmployeeType.HourlyMaintenance: print("Hourly, Maintenance")
                        case EmployeeType.Manager: print("Manager")
                    }
        }
        }

        return 0.0
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
