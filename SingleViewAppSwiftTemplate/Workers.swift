//
//  Worker.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 3/16/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

enum WorkerType {
    case hourlyFoodServices
    case hourlyRideServices
    case hourlyMaintenance
    case manager
    case contract
    case vendorStaff // added 9/20/17
}

enum WorkerErrorType: Error {
    case unknownWorkerType
    case missingRequiredData
    case invalidSSN
    
}

class Workers: Entrant {
    let entrantID: Int
    let workerType: WorkerType
    let firstName: String
    let lastName: String
    let streetAddress: String
    let city: String
    let state: String
    let zipCode: String
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

class Hourlys: Workers {
    // properties needed for this exercise are handled in the Worker superclass.
    // one could picture how the swipe into an area might be used to 
    // record hours worked in an area, for instance, in which case
    // there could be other properties specific to this WorkerType.
}

class Managers: Workers {
    let mgmtTier: String
    
    init(entrantID: Int, workerType: WorkerType, firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: String, socialSecurityNumber: String, dateOfBirth: Date, mgmtTier: String) {
        
        self.mgmtTier = mgmtTier
        
        super.init(entrantID: entrantID, workerType: workerType, firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: socialSecurityNumber, dateOfBirth: dateOfBirth)
    }
}

class Contractors: Workers {
    let projectNumber: Int
    
    init(entrantID: Int, workerType: WorkerType, firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: String, socialSecurityNumber: String, dateOfBirth: Date, projectNumber: Int) {
        
        self.projectNumber = projectNumber
        
        super.init(entrantID: entrantID, workerType: workerType, firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: socialSecurityNumber, dateOfBirth: dateOfBirth)
    }
}

 
class VendorStaff: Workers {
    let companyName: String
    let dateOfLastVisit: Date
    
    init(entrantID: Int, workerType: WorkerType, firstName: String, lastName: String, dateOfBirth: Date, companyName: String, dateOfLastVisit: Date) {
        
        self.companyName = companyName
        self.dateOfLastVisit = dateOfLastVisit

        super.init(entrantID: entrantID, workerType: workerType, firstName: firstName, lastName: lastName, streetAddress: "", city: "", state: "", zipCode: "", socialSecurityNumber: "", dateOfBirth: dateOfBirth)
    }
}

    
