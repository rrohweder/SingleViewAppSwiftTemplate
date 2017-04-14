//
//  LoadEntrants.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 4/11/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

var allGuests = [Guest]()
var guestDataFromPlist = [[String:AnyObject]]()
var allWorkers = [Worker]()
var workerDataFromPlist = [[String:AnyObject]]()

enum EntrantImportError: Error {
    case invalidResource(resourceName: String)
    case conversionFailure(resourceName: String)
    case missingRequiredField(fieldName: String)
}

// read/parse entrant data from plist, load data into a collection
class EntrantsPlistImporter {
    static func importDictionaries(fromFile name: String, ofType type: String) throws -> [[String: AnyObject]] { // a type method
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw EntrantImportError.invalidResource(resourceName: name)
        }
        guard let arrayOfDictionaries = NSArray.init(contentsOfFile: path) as? [[String: AnyObject]] else {
            throw EntrantImportError.conversionFailure(resourceName: name)
        }
        return arrayOfDictionaries
    }
}

func loadGuests(inputFile: String, fileType: String) throws -> [Guest] {
    var inputRecord = 0
    var guestType: GuestType
    var dateOfBirth: Date?
    var aGuest: Guest
    
    do {
        let guestArray = try EntrantsPlistImporter.importDictionaries(fromFile: inputFile, ofType: fileType)
        guestDataFromPlist = guestArray
    } catch let error {
        fatalError("\(error)")
    }
    
    for dict in guestDataFromPlist {
        inputRecord += 1
        
        guard let id = dict["ID"] as! Int? else {
            throw EntrantImportError.missingRequiredField(fieldName: "ID, input record \(inputRecord)")
        }
        
        guard let type = dict["guestType"] as! String? else {
            throw EntrantImportError.missingRequiredField(fieldName: "Type, input record \(inputRecord)")
        }
        switch (type) {
        case "Classic": guestType = .Classic
        case "VIP": guestType = .VIP
        case "FreeChild": guestType = .FreeChild
        default:throw EntrantImportError.conversionFailure(resourceName: "Unknown Type \"\(type)\", input record \(inputRecord)")
        }
        if guestType == .FreeChild {
            guard let dob = dict["dateOfBirth"] as! Date? else {
                // I guess I can't tell whether it is missing or a conversion failure...
                throw EntrantImportError.missingRequiredField(fieldName: "dateOfBirth, input record \(inputRecord)")
            }
            dateOfBirth = dob
        }
        if guestType == .FreeChild && dateOfBirth != nil {
            aGuest = FreeChildGuest(entrantID: id, guestType: guestType, dateOfBirth: dateOfBirth!)
        } else {
            aGuest = Guest(entrantID: id, guestType: guestType)
        }
        
        allGuests.append(aGuest)
        
    }
    return allGuests
    
}

func loadWorkers(inputFile: String, fileType: String) throws -> [Worker] {
    var inputRecord = 0
    var workerType: WorkerType
    
    do {
        let workerArray = try EntrantsPlistImporter.importDictionaries(fromFile: inputFile, ofType: fileType)
        workerDataFromPlist = workerArray
    } catch let error {
        fatalError("\(error)")
    }
    
    for dict in workerDataFromPlist {
        inputRecord += 1
        
        guard let id = dict["ID"] as! Int? else {
            throw EntrantImportError.missingRequiredField(fieldName: "ID, input record \(inputRecord)")
        }
        
        guard let type = dict["workerType"] as! String? else {
            throw EntrantImportError.missingRequiredField(fieldName: "workerType, input record \(inputRecord)")
        }
        switch type {
            case "HourlyFoodServices": workerType = .HourlyFoodServices
            case "HourlyRideServices": workerType = .HourlyRideServices
            case "HourlyMaintenance": workerType = .HourlyMaintenance
            case "Manager": workerType = .Manager
            default:throw EntrantImportError.conversionFailure(resourceName: "Unknown Type \"\(type)\", input record \(inputRecord)")
        }

        guard let firstName = dict["firstName"] as! String? else {
            throw EntrantImportError.missingRequiredField(fieldName: "firstName, input record \(inputRecord)")
        }

        guard let lastName = dict["lastName"] as! String? else {
            throw EntrantImportError.missingRequiredField(fieldName: "lastName, input record \(inputRecord)")
        }

        guard let streetAddress = dict["streetAddress"] as! String? else {
            throw EntrantImportError.missingRequiredField(fieldName: "streetAddress, input record \(inputRecord)")
        }
        
        guard let city = dict["city"] as! String? else {
            throw EntrantImportError.missingRequiredField(fieldName: "city, input record \(inputRecord)")
        }

        guard let state = dict["state"] as! String? else {
            throw EntrantImportError.missingRequiredField(fieldName: "state, input record \(inputRecord)")
        }
        
        guard let zipCode = dict["zipCode"] as! String? else {
            throw EntrantImportError.missingRequiredField(fieldName: "zipCode, input record \(inputRecord)")
        }
        
        guard let SSN = dict["SSN"] as! String? else {
            throw EntrantImportError.missingRequiredField(fieldName: "SSN, input record \(inputRecord)")
        }

        guard let dateOfBirth = dict["dateOfBirth"] as! Date? else {
            throw EntrantImportError.missingRequiredField(fieldName: "dateOfBirth, input record \(inputRecord)")
        }
        
        let aWorker =
Worker(entrantID: id, workerType: workerType, firstName: firstName,
                             lastName: lastName, streetAddress: streetAddress, city: city,
                             state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: dateOfBirth)
        
        allWorkers.append(aWorker)
        
    }
    return allWorkers
    
}

