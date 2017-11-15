//
//  LoadEntrants.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 4/11/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

var allGuests = [AnyObject]()
var guestDataFromPlist = [[String:AnyObject]]()
var allWorkers = [Workers]()
var workerDataFromPlist = [[String:AnyObject]]()
var allVendorStaff = [VendorStaff]()
var vendorStaffDataFromPlist = [[String:AnyObject]]()
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

func loadGuests(inputFile: String, fileType: String) throws -> [AnyObject] {
    var inputRecord = 0
    var guestType: GuestType
    var dateOfBirth: Date?
    var firstName: String
    var lastName: String
    var streetAddress: String
    var city: String
    var state: String
    var zip: String
    
    var aGuest: Guests
    
    do {
        let guestArray = try EntrantsPlistImporter.importDictionaries(fromFile: inputFile, ofType: fileType)
        guestDataFromPlist = guestArray
    } catch let error {
        fatalError("Could not load guests: \(error)")
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
            case "Classic":
                guestType = .classic
                aGuest = Guests(entrantID: id, guestType: guestType)
           
            case "VIP":
                guestType = .vIP
                aGuest = Guests(entrantID: id, guestType: guestType)

            case "FreeChild":
                guestType = .freeChild
                guard let dob = dict["dateOfBirth"] as! Date? else {
                    // I guess I can't tell whether it is missing or a conversion failure...
                    throw EntrantImportError.missingRequiredField(fieldName: "dateOfBirth, input record \(inputRecord)")
                }
                dateOfBirth = dob
                
                aGuest = FreeChildGuests(entrantID: id, guestType: guestType, dateOfBirth: dateOfBirth!)
            
            case "Senior":
                guestType = .senior
                guard let dob = dict["dateOfBirth"] as! Date? else {
                    // I guess I can't tell whether it is missing or a conversion failure...
                    throw EntrantImportError.missingRequiredField(fieldName: "dateOfBirth, input record \(inputRecord)")
                }
                dateOfBirth = dob
                
                guard let fn = dict["firstName"] as! String? else {
                    // I guess I can't tell whether it is missing or a conversion failure...
                    throw EntrantImportError.missingRequiredField(fieldName: "firstName, input record \(inputRecord)")
                }
                firstName = fn
                
                guard let ln = dict["lastName"] as! String? else {
                    throw EntrantImportError.missingRequiredField(fieldName: "lastName, input record \(inputRecord)")
                }
                lastName = ln
                
                aGuest = SeniorGuests(entrantID: id, guestType: guestType, firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth!)

            
            case "Season":
                guestType = .season
                guard let dob = dict["dateOfBirth"] as! Date? else {
                    throw EntrantImportError.missingRequiredField(fieldName: "dateOfBirth, input record \(inputRecord)")
                }
                dateOfBirth = dob

                guard let fn = dict["firstName"] as! String? else {
                    // I guess I can't tell whether it is missing or a conversion failure...
                    throw EntrantImportError.missingRequiredField(fieldName: "firstName, input record \(inputRecord)")
                }
                firstName = fn
                
                guard let ln = dict["lastName"] as! String? else {
                    throw EntrantImportError.missingRequiredField(fieldName: "lastName, input record \(inputRecord)")
                }
                lastName = ln
            
                guard let sa = dict["streetAddress"] as! String? else {
                    throw EntrantImportError.missingRequiredField(fieldName: "streetAddress, input record \(inputRecord)")
                }
                streetAddress = sa
                
                guard let ci = dict["city"] as! String? else {
                    throw EntrantImportError.missingRequiredField(fieldName: "streetAddress, input record \(inputRecord)")
                }
                city = ci
            
                guard let st = dict["state"] as! String? else {
                    throw EntrantImportError.missingRequiredField(fieldName: "streetAddress, input record \(inputRecord)")
                }
                state = st

                guard let zc = dict["zipCode"] as! String? else {
                    throw EntrantImportError.missingRequiredField(fieldName: "streetAddress, input record \(inputRecord)")
                }
                zip = zc

                aGuest = SeasonPassGuests(entrantID: id, guestType: guestType, firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth!, streetAddress: streetAddress, city: city, state: state, zipCode: zip)
            
            default:
                throw EntrantImportError.conversionFailure(resourceName: "Unknown Type \"\(type)\", input record \(inputRecord)")
        }
        
        allGuests.append(aGuest)
    }
    return allGuests
    
}

func loadWorkers(inputFile: String, fileType: String) throws -> [Workers] {
    var inputRecord = 0
    var workerType: WorkerType
    var aWorker: Workers
    
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
            case "HourlyFoodServices": workerType = .hourlyFoodServices
            case "HourlyRideServices": workerType = .hourlyRideServices
            case "HourlyMaintenance": workerType = .hourlyMaintenance
            case "Manager": workerType = .manager
            case "Contractor": workerType = .contract
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

        switch (workerType) {
            case .manager:
                guard let mgmtTier = dict["mgmtTier"] as! String? else {
                    throw EntrantImportError.missingRequiredField(fieldName: "mgmtTier, input record \(inputRecord)")
                }
                aWorker = Managers(entrantID: id, workerType: workerType, firstName: firstName,
                           lastName: lastName, streetAddress: streetAddress, city: city,
                           state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: dateOfBirth, mgmtTier: mgmtTier)

            case .contract:
                guard let projectNumber = dict["projectNumber"] as! Int? else {
                    throw EntrantImportError.missingRequiredField(fieldName: "projectNumber, input record \(inputRecord)")
                }
                aWorker = Contractors(entrantID: id, workerType: workerType, firstName: firstName,
                              lastName: lastName, streetAddress: streetAddress, city: city,
                              state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: dateOfBirth, projectNumber: projectNumber)

            default:
                aWorker = Workers(entrantID: id, workerType: workerType, firstName: firstName,
                                     lastName: lastName, streetAddress: streetAddress, city: city,
                                     state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: dateOfBirth)
        }
        allWorkers.append(aWorker)
        
    }
    return allWorkers
}


func loadVendorStaff(inputFile: String, fileType: String) throws -> [VendorStaff] {
    var inputRecord = 0
    var aVendorStaff: VendorStaff
    
    do {
        let workerArray = try EntrantsPlistImporter.importDictionaries(fromFile: inputFile, ofType: fileType)
        vendorStaffDataFromPlist = workerArray
    } catch let error {
        fatalError("\(error)")
    }
    
    for dict in vendorStaffDataFromPlist {
        inputRecord += 1
        
        guard let id = dict["ID"] as! Int? else {
            throw EntrantImportError.missingRequiredField(fieldName: "ID, input record \(inputRecord)")
        }

        /* not needed... will only get type vendorStaff
        guard let type = dict["workerType"] as! String? else {
            throw EntrantImportError.missingRequiredField(fieldName: "workerType, input record \(inputRecord)")
        }
        */
        
        guard let firstName = dict["firstName"] as! String? else {
            throw EntrantImportError.missingRequiredField(fieldName: "firstName, input record \(inputRecord)")
        }
        
        guard let lastName = dict["lastName"] as! String? else {
            throw EntrantImportError.missingRequiredField(fieldName: "lastName, input record \(inputRecord)")
        }
        
        
        guard let dateOfBirth = dict["dateOfBirth"] as! Date? else {
            throw EntrantImportError.missingRequiredField(fieldName: "dateOfBirth, input record \(inputRecord)")
        }
        
        guard let companyName = dict["companyName"] as! String? else {
            throw EntrantImportError.missingRequiredField(fieldName: "companyName, input record \(inputRecord)")
        }
        
        guard let dateOfLastVisit = dict["lastVisit"] as! Date? else {
            throw EntrantImportError.missingRequiredField(fieldName: "lastVisit, input record \(inputRecord)")
        }
        
        aVendorStaff = VendorStaff(entrantID: id, workerType: .vendorStaff, firstName: firstName,
                                  lastName: lastName, dateOfBirth: dateOfBirth, companyName: companyName, dateOfLastVisit: dateOfLastVisit)
            
        allVendorStaff.append(aVendorStaff)
    }
    return allVendorStaff
    
}
