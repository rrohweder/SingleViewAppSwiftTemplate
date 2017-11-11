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
    case Contract
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
        // Arguments used to create an object (such a Worker) should be checked by the caller
        // before calling the init()

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

class Contract: Worker {
    let projectNumber: Int
    
    init(entrantID: Int, workerType: WorkerType, firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: String, socialSecurityNumber: String, dateOfBirth: Date, projectNumber: Int) {
        
        self.projectNumber = projectNumber
        
        super.init(entrantID: entrantID, workerType: workerType, firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: socialSecurityNumber, dateOfBirth: dateOfBirth)
    }
}

 
class VendorStaff: Worker {
    var companyName: String
    var dateOfLastVisit: Date
    
    init(entrantID: Int, workerType: WorkerType, firstName: String, lastName: String, dateOfBirth: Date, companyName: String, dateOfLastVisit: Date) {
        
        self.companyName = companyName
        self.dateOfLastVisit = dateOfLastVisit

        super.init(entrantID: entrantID, workerType: workerType, firstName: firstName, lastName: lastName, streetAddress: "", city: "", state: "", zipCode: "", socialSecurityNumber: "", dateOfBirth: dateOfBirth)
    }
}

    
