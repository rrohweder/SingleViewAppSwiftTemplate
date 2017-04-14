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
}


