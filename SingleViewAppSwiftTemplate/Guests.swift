//
//  Guests.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 3/16/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

enum GuestType {
    case classic
    case vIP
    case freeChild
    case senior
    case season
}

enum GuestErrorType: Error {
    case unknownGuestType
    case missingRequiredData
}

class Guests: Entrant {
    let entrantID: Int
    let guestType: GuestType
    
    init(entrantID: Int, guestType: GuestType) {
        self.entrantID = entrantID
        self.guestType = guestType
    }    
}

class FreeChildGuests: Guests {
    let dateOfBirth: Date
    
    init(entrantID: Int, guestType: GuestType, dateOfBirth: Date) {
        self.dateOfBirth = dateOfBirth
        super.init(entrantID: entrantID, guestType: guestType)
    }
}

class SeniorGuests: Guests {
    let firstName: String
    let lastName: String
    let dateOfBirth: Date
    
    init(entrantID: Int, guestType: GuestType, firstName: String, lastName: String, dateOfBirth: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        super.init(entrantID: entrantID, guestType: guestType)
    }
}

class SeasonPassGuests: Guests {
    let dateOfBirth: Date
    let firstName: String
    let lastName: String
    let streetAddress: String
    let city: String
    let state: String
    let zipCode: String
    
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

class ClassicGuests: Guests {
    // needed?
    // using the Role-Based access/priveledge model, the work for this
    // exercise doesn't need properties specific to ClassicGuest, and I
    // am finding it hard to think of properties unique to Classic Guests,
    // but not VIP or Free Child guests - for consistency, however, I
    // included this (currently unused) class definition.
}

class VIPGuests: Guests {
    // Needed?
    // using the Role-Based access/priveledge model, the work for this
    // exercise doesn't need properties specific to VIPGuest. One could
    // easily imagine having properties like 'birthday' (just month/day),
    // or some preference (vegetarian?) that would be unique to VIP guests.
}

