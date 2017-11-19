//
//  GetEntrantRec.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 11/10/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

class GetEntrant {

    init() {
        loadAllData()
    }
    
// return an entrant object for the specified entrant-type
// use filter to get JUST the records I want
func getEntrant(entrantType: GuestType) -> Guests? {
    var filteredArray = [AnyObject]()
    
    switch entrantType {
    case GuestType.freeChild:
        filteredArray = guests.filter() { ($0 as! Guests).guestType == GuestType.freeChild }
        break
        
    case GuestType.classic:
        filteredArray = guests.filter() { ($0 as! Guests).guestType == GuestType.classic }
        break
        
    case GuestType.season:
        filteredArray = guests.filter() { ($0 as! Guests).guestType == GuestType.season }
        break
        
    case GuestType.senior:
        filteredArray = guests.filter() { ($0 as! Guests).guestType == GuestType.senior }
        break
        
    case GuestType.vIP:
        filteredArray = guests.filter() { ($0 as! Guests).guestType == GuestType.vIP }
        break
    } // end switch (entrantType)
    
    if filteredArray.count > 0 {
        return (filteredArray[0] as! Guests)
    }
    return nil
    
} // end getEntrant(Guest)

func getEntrant(entrantType: WorkerType) -> Workers? {
    let filteredArray = workers.filter() { $0.workerType == entrantType }
    if filteredArray.count > 0 {
        return filteredArray[0]
    }
    return nil
} // end getEntrant(worker)

func getVendorEntrant() -> VendorStaff? {
    if vendorFolks.count > 0 {
        return vendorFolks[0]
    }
    return nil
} // end getVendorEntrant()

}
