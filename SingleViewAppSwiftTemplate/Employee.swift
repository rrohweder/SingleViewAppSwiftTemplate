//
//  Employee.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 3/16/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

enum EmployeeType {
    case HourlyFoodServices
    case HourlyRideServices
    case HourlyMaintenance
    case Manager
}

enum EmployeeErrorType: Error {
    case unknownEmployeeType
    case missingRequiredData
    case invalidSSN
    
}

class Employee: Entrant {
    let employeeType: EmployeeType
    let firstName: String
    let lastName: String
    let streetAddress: String
    let city: String
    let state: String
    let zipCode: String
    let socialSecurityNumber: String
    let dateofBirth: Date

    init(employeeType: EmployeeType, firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: String, socialSecurityNumber: String, dateofBirth: Date)
    {
        self.employeeType = employeeType
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.socialSecurityNumber = socialSecurityNumber
        self.dateofBirth = dateofBirth
    }
    
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


class Hourly: Employee {
    // properties are the same as Manager, handled in Employee
}

class Manager: Employee {
    // properties are the same as Hourly, handled in Employee
}

/* for Part II:
class Contract {
    // properties are the same as Hourly and Manager, handled in Employee
}
*/


/*
    canIgetin(joe.workerType, kitchen)
    
 could have the class contain
 
 var guestType
 
 or could do this.
 
 class Shape {
    class func className() -> String {
        return "Shape"
    }
 }
 
 class Square: Shape {
    override class func className() -> String {
        return "Square"
    }
 }

*/
 
 
 
 
    
