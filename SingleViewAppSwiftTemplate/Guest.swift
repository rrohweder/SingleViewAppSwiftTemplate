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

class ClassicGuest: Guest {
    
}

class VIPGuest: Guest {
    
}

class Guest {
    var guestType:GuestType = GuestType.Classic
}
