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
    let dateofBirth: Date

    init(entrantID: Int, workerType: WorkerType, firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: String, socialSecurityNumber: String, dateofBirth: Date)
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
        self.dateofBirth = dateofBirth
    }
    
}

// Arguments used to create an object (such a Worker) should be checked before calling the object init
// These functions can be used by the caller to do that:

class Hourly: Worker {
    // properties needed for this exercise are handled in the Worker superclass.
    // one could picture how the swipe into an area might be used to 
    // record hours worked in an area, for instance, in which case
    // there could be other properties specific to this WorkerType.
}

class Manager: Worker {
    // properties needed for this exercise are handled in the Worker superclass
    // one could picture how the swipe into an area might be used to record
    // hours in an area (to support a Manager Area Coverage Report), for instance, 
    // in which case there could be other properties specific to this WorkerType.
}

 
 
    
