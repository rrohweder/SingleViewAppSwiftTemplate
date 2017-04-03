//
//  Guests.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 3/16/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

// look at 
// https://medium.com/swift-programming/how-to-do-proper-lazy-loading-in-swift-b8bc57dbc7b9#.3pqq7p354

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
    // don't need this now - can tell by class
    let guestType:GuestType
    
    init(guestType: GuestType) {
        self.guestType = guestType
    }
}

class ClassicGuest: Guest {
    
}

class VIPGuest: Guest {
    
}


