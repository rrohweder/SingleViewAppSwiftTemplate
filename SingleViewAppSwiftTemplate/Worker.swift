//
//  Workers.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 3/16/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

enum WorkerType {
    case HourlyEmployeeFoodServices
    case HourlyEmployeeRideServices
    case HourlyEmployeeMaintenance
    case Manager
}

class Worker:Entrant {
    var workerType: WorkerType
    init() {
        print("I don't know what is needed here")
    }
    
    var firstName: String
    var lastName: String
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: String
    var socialSecurityNumber: String
    var dateofBirth: Date
    
    func validSSN() -> Bool {
        if socialSecurityNumber.characters.count == 9 {
            return true
        } else {
            return false
        }
    }
    
    func validZipCode() -> Bool {
        if (zipCode.characters.count == 5 || zipCode.characters.count == 9) {
            return true
        } else {
            return false
        }
    }
}
