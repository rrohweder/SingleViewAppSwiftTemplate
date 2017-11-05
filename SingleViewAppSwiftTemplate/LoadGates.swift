//
//  LoadGates.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 4/14/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

var allRides = [Ride]()
var rideDataFromPlist = [[String:AnyObject]]()

var allVendors = [Vendor]()
var vendorDataFromPlist = [[String:AnyObject]]()

var allNonPublics = [NonPublic]()
var nonpublicDataFromPlist = [[String:AnyObject]]()


enum GatesImportError: Error {
    case invalidResource(resourceName: String)
    case conversionFailure(resourceName: String)
    case missingRequiredField(fieldName: String)
}

// read/parse gate data from plist, load data into a collection
class GatesPlistImporter {
    static func importDictionaries(fromFile name: String, ofType type: String) throws -> [[String: AnyObject]] { // a type method
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw GatesImportError.invalidResource(resourceName: name)
        }
        guard let arrayOfDictionaries = NSArray.init(contentsOfFile: path) as? [[String: AnyObject]] else {
            throw GatesImportError.conversionFailure(resourceName: name)
        }
        return arrayOfDictionaries
    }
}

func loadRides(inputFile: String, fileType: String) throws -> [AnyObject] {
    var inputRecord = 0
    var gateType: GateType
    var aRide: Ride
    var ageRestricted: Bool
    
    do {
        let rideArray = try GatesPlistImporter.importDictionaries(fromFile: inputFile, ofType: fileType)
        rideDataFromPlist = rideArray
    } catch let error {
        fatalError("\(error)")
    }
    
    for dict in rideDataFromPlist {
        inputRecord += 1
        gateType = GateType.RideRides
        guard let id = dict["ID"] as! Int? else {
              throw GatesImportError.missingRequiredField(fieldName: "ID, input record \(inputRecord)")
        }
        guard let name = dict["Name"] as! String? else {
            throw GatesImportError.missingRequiredField(fieldName: "Name, input record \(inputRecord)")
        }
        if let restricted = dict["AgeRestricted"] as! Bool? {
            ageRestricted = restricted
        } else {
            ageRestricted = false
        }

        aRide = Ride(gateID: id, gateType: gateType, gateName: name, ageRestricted: ageRestricted)
        
        allRides.append(aRide)
    }
    return allRides
}


func loadVendors(inputFile: String, fileType: String) throws -> [AnyObject] {
    var inputRecord = 0
    var gateType: GateType
    var aVendor: Vendor

    do {
        let vendorArray = try GatesPlistImporter.importDictionaries(fromFile: inputFile, ofType: fileType)
        vendorDataFromPlist = vendorArray
    } catch let error {
        fatalError("\(error)")
    }
    
    for dict in vendorDataFromPlist {
        inputRecord += 1
        
        guard let id = dict["ID"] as! Int? else {
            throw GatesImportError.missingRequiredField(fieldName: "ID, input record \(inputRecord)")
        }
        guard let type = dict["Type"] as! String? else {
            throw GatesImportError.missingRequiredField(fieldName: "Type, input record \(inputRecord)")
        }
        guard let name = dict["Name"] as! String? else {
            throw GatesImportError.missingRequiredField(fieldName: "Name, input record \(inputRecord)")
        }

        switch type {
            case "Food": gateType = .FoodVendor
            case "Merchandise": gateType = .MerchVendor
            default: throw EntrantImportError.conversionFailure(resourceName: "Unknown Type \"\(type)\", input record \(inputRecord)")
        }
        aVendor = Vendor(gateID: id, gateType: gateType, gateName: name)
        allVendors.append(aVendor)
    }
    return allVendors
} // loadVendors()

func loadNonPublics(inputFile: String, fileType: String) throws -> [AnyObject] {
    var inputRecord = 0
    var gateType: GateType
    var aNonPublic: NonPublic
    
    do {
        let nonpublicArray = try GatesPlistImporter.importDictionaries(fromFile: inputFile, ofType: fileType)
        nonpublicDataFromPlist = nonpublicArray
    } catch let error {
        fatalError("\(error)")
    }
    
    for dict in nonpublicDataFromPlist {
        inputRecord += 1
        
        guard let id = dict["ID"] as! Int? else {
            throw GatesImportError.missingRequiredField(fieldName: "ID, input record \(inputRecord)")
        }
        guard let type = dict["Type"] as! String? else {
            throw GatesImportError.missingRequiredField(fieldName: "Type, input record \(inputRecord)")
        }
        switch (type) {
            case "Kitchen": gateType = GateType.Kitchen
            case "Ride Control": gateType = GateType.RideControl
            case "Maintenance": gateType = GateType.Maintenance
            case "Office": gateType = GateType.Office
        default: throw EntrantImportError.conversionFailure(resourceName: "Unknown Type \"\(type)\", input record \(inputRecord)")
        }
        guard let name = dict["Name"] as! String? else {
            throw GatesImportError.missingRequiredField(fieldName: "Name, input record \(inputRecord)")
        }
        
        aNonPublic = NonPublic(gateID: id, gateType: gateType, gateName: name)
        allNonPublics.append(aNonPublic)
    }
    return allNonPublics
} // loadVendors()
