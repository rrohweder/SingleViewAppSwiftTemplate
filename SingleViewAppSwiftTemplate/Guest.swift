//
//  Guests.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 3/16/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

enum GuestType {
    case Classic
    case VIP
    case FreeChild
    case Senior
    case Season
}

enum GuestErrorType: Error {
    case unknownGuestType
    case missingRequiredData
}

class Guest: Entrant {
    let entrantID: Int
    var guestType: GuestType
    
    init(entrantID: Int, guestType: GuestType) {
        self.entrantID = entrantID
        self.guestType = guestType
    }    
}

class FreeChildGuest: Guest {
    var dateOfBirth: Date
    
    init(entrantID: Int, guestType: GuestType, dateOfBirth: Date) {
        self.dateOfBirth = dateOfBirth
        super.init(entrantID: entrantID, guestType: guestType)
    }
}

class SeniorGuest: Guest {
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    
    init(entrantID: Int, guestType: GuestType, firstName: String, lastName: String, dateOfBirth: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        super.init(entrantID: entrantID, guestType: guestType)
    }
}

class SeasonPassGuest: Guest {
    var dateOfBirth: Date
    var firstName: String
    var lastName: String
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: String
    
    init(entrantID: Int, guestType: GuestType, firstName: String, lastName: String, dateOfBirth: Date,
         streetAddress: String, city: String, state: String, zipCode: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode

        super.init(entrantID: entrantID, guestType: guestType)
    }
    
}

class ClassicGuest: Guest {
    // needed?
    // using the Role-Based access/priveledge model, the work for this
    // exercise doesn't need properties specific to ClassicGuest, and I
    // am finding it hard to think of properties unique to Classic Guests,
    // but not VIP or Free Child guests - for consistency, however, I
    // included this (currently unused) class definition.
}

class VIPGuest: Guest {
    // Needed?
    // using the Role-Based access/priveledge model, the work for this
    // exercise doesn't need properties specific to VIPGuest. One could
    // easily imagine having properties like 'birthday' (just month/day),
    // or some preference (vegetarian?) that would be unique to VIP guests.
    // FIXME: "Overriding declaration requires an 'override' keyword" error on next line. 
    // Why here and not in the cases above?
    /*
    init(entrantID: Int, guestType: GuestType) {
        super.init(entrantID: entrantID, guestType: guestType)
    }
    */
}

