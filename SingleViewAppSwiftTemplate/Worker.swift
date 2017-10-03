//
//  Worker.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 3/16/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

enum WorkerType {
    case HourlyFoodServices
    case HourlyRideServices
    case HourlyMaintenance
    case Manager
    case VendorStaff // added 9/20/17
}

enum WorkerErrorType: Error {
    case unknownWorkerType
    case missingRequiredData
    case invalidSSN
    
}

class Worker: Entrant {
    let entrantID: Int
    var workerType: WorkerType
    var firstName: String
    var lastName: String
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: String
    let socialSecurityNumber: String
    let dateOfBirth: Date

    init(entrantID: Int, workerType: WorkerType, firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: String, socialSecurityNumber: String, dateOfBirth: Date)
    {
        // FIXME: test for required values, return nil if not complete. Alert?
        self.entrantID = entrantID
        self.workerType = workerType
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.socialSecurityNumber = socialSecurityNumber
        self.dateOfBirth = dateOfBirth
    }
    
}

// Arguments used to create an object (such a Worker) should be checked 
// before calling the object init()


class Hourly: Worker {
    // properties needed for this exercise are handled in the Worker superclass.
    // one could picture how the swipe into an area might be used to 
    // record hours worked in an area, for instance, in which case
    // there could be other properties specific to this WorkerType.
}

class Manager: Worker {
    let mgmtTier: String
    
    init(entrantID: Int, workerType: WorkerType, firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: String, socialSecurityNumber: String, dateOfBirth: Date, mgmtTier: String) {
        
        self.mgmtTier = mgmtTier
        
        super.init(entrantID: entrantID, workerType: workerType, firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: socialSecurityNumber, dateOfBirth: dateOfBirth)
    }
}

// FIXME: VendorStaff has two extra properties, but doesn't need the address and ssn stuff... is it a proper subclass?  Or should I make it a another class conforming to Entrant?
/*
class VendorStaff: Worker {
    var vendorCompanyName: String
    var dateOfLastVisit: Date
    
    init(entrantID: Int, workerType: WorkerType, firstName: String, lastName: String, vendorCompanyName: String, dateOfBirth: Date, dateOfLastVisit: Date) {
        
        self.vendorCompanyName = vendorCompanyName
        self.dateOfLastVisit = dateOfLastVisit

        super.init(entrantID: entrantID, workerType: workerType, firstName: <#String#>, lastName: <#String#>, streetAddress: <#String#>, city: <#String#>, state: <#String#>, zipCode: <#String#>, socialSecurityNumber: <#String#>, dateOfBirth: <#Date#>)
    }
}
 */

    
