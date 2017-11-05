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
        print("guestRules: \(guestRules)")
    }

    
    func mapTextToCustomTypes(textRules: [String:Any]) -> Void {
        var typeRules = [GateType:Bool]()
        
        for (key,value) in textRules["guests"] as! [String:[String:Bool]] {
            
            if let accessSet = value["RideRides"] {
                typeRules[GateType.RideRides] = accessSet
            }

            if let accessSet = value["AmusementAreas"] {
                typeRules[GateType.Amusement] = accessSet
            }
            
            if let accessSet =  value["RideControlAreas"] {
                typeRules[GateType.RideControl] = accessSet
            }
            
            if let accessSet = value["KitchenAreas"] {
                typeRules[GateType.Kitchen] = accessSet
            }
            
            if let accessSet = value["Maintenance"] {
                typeRules[GateType.Maintenance] = accessSet
            }
            
            if let accessSet = value["OfficeAreas"] {
                typeRules[GateType.Office] = accessSet
            }

            switch (key) {
                case "Classic":
                    guestRules[GuestType.Classic] = typeRules
                case "Senior":
                    guestRules[GuestType.Senior] = typeRules
                case "Season":
                    guestRules[GuestType.Season] = typeRules
                case "Child":
                    guestRules[GuestType.FreeChild] = typeRules
                case "VIP":
                    guestRules[GuestType.VIP] = typeRules
                default: break
            }
            // print("guestRules[GuestType.Season]: \(guestRules[GuestType.Season])")  // this works
            // print("guestRules[GuestType.Season][GateType.Amusement]: \(guestRules[GuestType.Season]![GateType.Amusement])") // this works

            typeRules = [GateType:Bool]() // need to clear it, I think.
        }
        
        for (key,value) in textRules["workers"] as! [String:[String:Bool]] {
            
            if let accessSet = value["RideRides"] {
                typeRules[GateType.RideRides] = accessSet
            }
            
            if let accessRules = value["AmusementAreas"] {
                typeRules[GateType.Amusement] = accessRules
            }
            
            if let accessRules = value["RideControlAreas"] {
                typeRules[GateType.RideControl] = accessRules
            }
            
            if let accessRules = value["KitchenAreas"] {
                typeRules[GateType.Kitchen] = accessRules
            }
            
            if let accessRules = value["Maintenance"] {
                typeRules[GateType.Maintenance] = accessRules
            }
            
            if let accessRules = value["OfficeAreas"] {
                typeRules[GateType.Office] = accessRules
            }
            
            switch (key) {
            case "FoodServices":
                workerRules[WorkerType.HourlyFoodServices] = typeRules
            case "RideServices":
                workerRules[WorkerType.HourlyRideServices] = typeRules
            case "Mainenance":
                workerRules[WorkerType.HourlyMaintenance] = typeRules
            case "Manager":
                workerRules[WorkerType.Manager] = typeRules
            default: break
            }
            typeRules = [GateType:Bool]() // need to clear it, I think.
        }

        for (key,value) in textRules["companies"] as! [String:[String:Bool]] {
            if let accessRules = value["RideRides"] {
                typeRules[GateType.RideRides] = accessRules
            }
            if let accessRules = value["AmusementAreas"] {
                typeRules[GateType.Amusement] = accessRules
            }
            if let accessRules = value["RideControlAreas"] {
                typeRules[GateType.RideControl] = accessRules
            }
            if let accessRules = value["KitchenAreas"] {
                typeRules[GateType.Kitchen] = accessRules
            }
            if let accessRules = value["Maintenance"] {
                typeRules[GateType.Maintenance] = accessRules
            }
            if let accessRules = value["OfficeAreas"] {
                typeRules[GateType.Office] = accessRules
            }
            vendorStaffRules[key] = typeRules
           
            typeRules = [GateType:Bool]() // need to clear it, I think.
        }
        
        for (key,value) in textRules["projects"] as! [String:[String:Bool]] {
            if let accessRules = value["RideRides"] {
                typeRules[GateType.RideRides] = accessRules
            }
            if let accessRules = value["AmusementAreas"] {
                typeRules[GateType.Amusement] = accessRules
            }
            if let accessRules = value["RideControlAreas"] {
                typeRules[GateType.RideControl] = accessRules
            }
            if let accessRules = value["KitchenAreas"] {
                typeRules[GateType.Kitchen] = accessRules
            }
            if let accessRules = value["Maintenance"] {
                typeRules[GateType.Maintenance] = accessRules
            }
            if let accessRules = value["OfficeAreas"] {
                typeRules[GateType.Office] = accessRules
            }
            
            contractorRules[key] = typeRules
            typeRules = [GateType:Bool]() // need to clear it, I think.
        }
    }
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



