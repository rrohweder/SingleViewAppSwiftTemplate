//
//  PermissionsAndBenefits.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 4/11/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

//  Why not just do this?
//  entrantsAllowed = accessDictionary[gate]
//    accessAnswer = entrantsAllowed.contains(requestor_type)
// if let discount = discountAvailable[requestor_type] {
//    discountAmount = discount
// if let skip = skipLine[requestor_type] {
//    skipLine = skip
// if nothing puked, return access, discount, and skip answers.
// answer: to show that we have learned how to use class / subclass, protocol, collections, etc.


import Foundation

let guestRolesAccess:[GateType: [GuestType]] = [
    .Amusement:[.Classic,.VIP,.FreeChild],
    .FoodVendor:[.Classic,.VIP,.FreeChild],
    .MerchVendor:[.Classic,.VIP,.FreeChild]
]

let guestRolesDiscount:[ProductType:[GuestType:Int]] = [
    .Food:
        [.VIP:10, .Senior:10, .Season:10],
    .Merchandise:
        [.VIP:20, .Senior:10, .Season:20]
]

let guestRolesSkipPrivilege:[GateType:[GuestType]] = [
    .Amusement:[.VIP]
]

let workerRolesAccess:[GateType: [WorkerType]] = [
    .Amusement:[.HourlyFoodServices, .HourlyRideServices, .HourlyMaintenance, .Manager],
    .FoodVendor:[.HourlyFoodServices, .HourlyRideServices, .HourlyMaintenance, .Manager],
    .MerchVendor:[.HourlyFoodServices, .HourlyRideServices, .HourlyMaintenance, .Manager],
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

func accessPermitted(requestor: Entrant, gate: Gate) -> Bool {
    var permitted = false
    
    let gateType = gate.gateType
    switch (gateType) {
    case .Amusement:
        if (requestor is Guest) {
            let guestRequestor = requestor as! Guest
            let ride = gate as! Ride // Amusement == Ride
            
            if var isPermitted = (guestRolesAccess[.Amusement]?.contains(guestRequestor.guestType)) {
                if guestRequestor.guestType == .FreeChild && ride.ageRestricted {
                    isPermitted = false
                }
                permitted = isPermitted
            }
        } else if requestor is Worker {
            let workerRequestor = requestor as! Worker
            if let isPermitted = (workerRolesAccess[.Amusement]?.contains(workerRequestor.workerType)) {
                permitted = isPermitted
            }
        }
        
    case .FoodVendor, .MerchVendor: permitted = true
        
    case .Kitchen:
        if requestor is Worker {
            let workerRequestor = requestor as! Worker
            if let isPermitted = (workerRolesAccess[.Kitchen]?.contains(workerRequestor.workerType)) {
                permitted = isPermitted
            }
        }
        
    case .Maintenance:
        if requestor is Worker {
            let workerRequestor = requestor as! Worker
            if let isPermitted = (workerRolesAccess[.Maintenance]?.contains(workerRequestor.workerType)) {
                permitted = isPermitted
            }
        }
        
    case .Office:
        if requestor is Worker {
            let workerRequestor = requestor as! Worker
            if let isPermitted = (workerRolesAccess[.Office]?.contains(workerRequestor.workerType)) {
                permitted = isPermitted
            }
        }
        
    case .RideControl:
        if requestor is Worker {
            let workerRequestor = requestor as! Worker
            if let isPermitted = (workerRolesAccess[.RideControl]?.contains(workerRequestor.workerType)) {
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
            if let discount = guestRolesDiscount[.Food]?[guestRequestor.guestType] {
                return discount
            }
        } else if requestor is Worker {
            let workerRequestor = requestor as! Worker
            
            if let discount = workerRolesDiscount[.Food]?[workerRequestor.workerType] {
                return discount
            }
        }
        
    case .Merchandise:
        if (requestor is Guest) {
            let guestRequestor = requestor as! Guest
            
            if let discount = guestRolesDiscount[.Merchandise]?[guestRequestor.guestType] {
                return discount
            }
            
        } else if requestor is Worker {
            let workerRequestor = requestor as! Worker
            
            if let discount = workerRolesDiscount[.Merchandise]?[workerRequestor.workerType] {
                return discount
            }
        }
    }
    return 0
}

func canSkipLine(requestor: Entrant, gateType: GateType) -> Bool {
    var permitted = false
    if (requestor is Guest) {
        let guestRequestor = requestor as! Guest
        permitted = (guestRolesSkipPrivilege[gateType]!.contains(guestRequestor.guestType))
    }
    return permitted
}
