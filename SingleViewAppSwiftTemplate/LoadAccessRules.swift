//
//  LoadAccessRules.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 10/14/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

var guestRules = [GuestType:[GateType:Bool]]()
var workerRules = [WorkerType:[GateType:Bool]]()
var vendorStaffRules = [String:[GateType:Bool]]()
var contractorRules = [String:[GateType:Bool]]()

class RulesImporter {
    var textRules = [String:Any]()
    
    // this doesn't really need to return anything - it just needs to fill the rules structures or throw-up.
    func loadRules() throws -> Void { // a type method
        guard let path = Bundle.main.path(forResource: "AccessRules", ofType: "plist") else {
            throw EntrantImportError.invalidResource(resourceName: "AccessRules.plist")
        }
        guard let textRules = NSDictionary.init(contentsOfFile: path) as! [String: AnyObject]? else {
            throw EntrantImportError.conversionFailure(resourceName: "AccessRules.plist")
        }
        mapTextToCustomTypes(textRules: textRules)
    }

    
    func mapTextToCustomTypes(textRules: [String:Any]) -> Void {
        var typeRules = [GateType:Bool]()
        
        for (key,value) in textRules["guests"] as! [String:[String:Bool]] {
            
            if let accessSet = value["RideRides"] {
                typeRules[GateType.rideRides] = accessSet
            }
            if let accessSet = value["AmusementAreas"] {
                typeRules[GateType.amusement] = accessSet
            }
            if let accessSet =  value["RideControlAreas"] {
                typeRules[GateType.rideControl] = accessSet
            }
            if let accessSet = value["KitchenAreas"] {
                typeRules[GateType.kitchen] = accessSet
            }
            if let accessSet = value["Maintenance"] {
                typeRules[GateType.maintenance] = accessSet
            }
            if let accessSet = value["OfficeAreas"] {
                typeRules[GateType.office] = accessSet
            }
            if let accessSet = value["FoodVendor"] {
                typeRules[GateType.foodVendor] = accessSet
            }
            if let accessSet = value["MerchVendor"] {
                typeRules[GateType.merchVendor] = accessSet
            }

            switch (key) {
                case "Classic":
                    guestRules[GuestType.classic] = typeRules
                case "Senior":
                    guestRules[GuestType.senior] = typeRules
                case "Season":
                    guestRules[GuestType.season] = typeRules
                case "FreeChild":
                    guestRules[GuestType.freeChild] = typeRules
                case "VIP":
                    guestRules[GuestType.vIP] = typeRules
                default: break
            }

            typeRules = [GateType:Bool]() // need to clear it, I think.
        }
        
        for (key,value) in textRules["workers"] as! [String:[String:Bool]] {
            if let accessSet = value["RideRides"] {
                typeRules[GateType.rideRides] = accessSet
            }
            if let accessRules = value["AmusementAreas"] {
                typeRules[GateType.amusement] = accessRules
            }
            if let accessRules = value["RideControlAreas"] {
                typeRules[GateType.rideControl] = accessRules
            }
            if let accessRules = value["KitchenAreas"] {
                typeRules[GateType.kitchen] = accessRules
            }
            if let accessRules = value["Maintenance"] {
                typeRules[GateType.maintenance] = accessRules
            }
            if let accessRules = value["OfficeAreas"] {
                typeRules[GateType.office] = accessRules
            }
            if let accessRules = value["FoodVendor"] {
                typeRules[GateType.foodVendor] = accessRules
            }
            if let accessRules = value["MerchVendor"] {
                typeRules[GateType.merchVendor] = accessRules
            }

            switch (key) {
            case "FoodServices":
                workerRules[WorkerType.hourlyFoodServices] = typeRules
            case "RideServices":
                workerRules[WorkerType.hourlyRideServices] = typeRules
            case "Maintenance":
                workerRules[WorkerType.hourlyMaintenance] = typeRules
            case "Manager":
                workerRules[WorkerType.manager] = typeRules
            default: break
            }
            typeRules = [GateType:Bool]() // need to clear it, I think.
        }

        for (key,value) in textRules["companies"] as! [String:[String:Bool]] {
            if let accessRules = value["RideRides"] {
                typeRules[GateType.rideRides] = accessRules
            }
            if let accessRules = value["AmusementAreas"] {
                typeRules[GateType.amusement] = accessRules
            }
            if let accessRules = value["RideControlAreas"] {
                typeRules[GateType.rideControl] = accessRules
            }
            if let accessRules = value["KitchenAreas"] {
                typeRules[GateType.kitchen] = accessRules
            }
            if let accessRules = value["Maintenance"] {
                typeRules[GateType.maintenance] = accessRules
            }
            if let accessRules = value["OfficeAreas"] {
                typeRules[GateType.office] = accessRules
            }
            if let accessRules = value["FoodVendor"] {
                typeRules[GateType.foodVendor] = accessRules
            }
            if let accessRules = value["MerchVendor"] {
                typeRules[GateType.merchVendor] = accessRules
            }
            vendorStaffRules[key] = typeRules
           
            typeRules = [GateType:Bool]() // need to clear it, I think.
        }
        
        for (key,value) in textRules["projects"] as! [String:[String:Bool]] {
            if let accessRules = value["RideRides"] {
                typeRules[GateType.rideRides] = accessRules
            }
            if let accessRules = value["AmusementAreas"] {
                typeRules[GateType.amusement] = accessRules
            }
            if let accessRules = value["RideControlAreas"] {
                typeRules[GateType.rideControl] = accessRules
            }
            if let accessRules = value["KitchenAreas"] {
                typeRules[GateType.kitchen] = accessRules
            }
            if let accessRules = value["Maintenance"] {
                typeRules[GateType.maintenance] = accessRules
            }
            if let accessRules = value["OfficeAreas"] {
                typeRules[GateType.office] = accessRules
            }
            if let accessRules = value["FoodVendor"] {
                typeRules[GateType.foodVendor] = accessRules
            }
            if let accessRules = value["MerchVendor"] {
                typeRules[GateType.merchVendor] = accessRules
            }

            contractorRules[key] = typeRules
            typeRules = [GateType:Bool]() // need to clear it, I think.
        }
    }
}
    
