//
//  Gates.swift
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
 
 

enum GateTypes {
    case Amusement
    case Kitchen
    case RideControl
    case Maintenance
    case Office
}

class Gates {
    
    
   // should the function be "func swipe(requestor: Entrant, gate: GateTypes, &accessAnswer:Bool, &discountAmount: int, &skipLine: Bool) -> Bool
    
    func AccessPermitted(requestor: Entrant, gate: GateTypes) -> Bool {
        
        // why not just do this?
        //  entrantsAllowed = accessDictionary[gate]
        //    accessAnswer = entrantsAllowed.contains(requestor_type)
        // if let discount = discountAvailable[requestor_type] {
        //    discountAmount = discount
        // if let skip = skipLine[requestor_type] {
        //    skipLine = skip
        // if nothing puked, return true
        
        
        if (requestor is Guest) {
            let guestRequestor = requestor as! Guest
            switch guestRequestor.guestType {
                case GuestType.Classic: print("Classic")
                case GuestType.VIP: print("VIP")
                case GuestType.FreeChild: print("Free Child")
            }
            
        } else if requestor is Worker {
            let workerRequestor = requestor as! Worker
            switch workerRequestor.workerType {
                case WorkerType.HourlyEmployeeFoodServices: print("Hourly, Food Services")
                case WorkerType.HourlyEmployeeRideServices: print("Hourly, Ride Services")
                case WorkerType.HourlyEmployeeMaintenance: print("Hourly, Maintenance")
                case WorkerType.Manager: print("Manager")
            }
        }
        return true
    }
}
