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
    let guestID: Int
    var guestType: GuestType
    
    init(guestID: Int, guestType: GuestType) {
        self.guestID = guestID
        self.guestType = guestType
    }
}

class ClassicGuest: Guest {
    // needed?
}

class VIPGuest: Guest {
    // Needed?
}


