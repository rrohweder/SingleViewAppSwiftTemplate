//
//  GetEntrantRec.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 11/10/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

// use filter to get JUST the records I want
func getEntrant(entrantType: GuestType) -> Guest? {
    var filteredArray = [AnyObject]()
    
    switch entrantType {
    case GuestType.FreeChild:
        filteredArray = guests.filter() { ($0 as! Guest).guestType == GuestType.FreeChild }
        break
        
    case GuestType.Classic:
        filteredArray = guests.filter() { ($0 as! Guest).guestType == GuestType.Classic }
        break
        
    case GuestType.Season:
        filteredArray = guests.filter() { ($0 as! Guest).guestType == GuestType.Season }
        break
        
    case GuestType.Senior:
        filteredArray = guests.filter() { ($0 as! Guest).guestType == GuestType.Senior }
        break
        
    case GuestType.VIP:
        filteredArray = guests.filter() { ($0 as! Guest).guestType == GuestType.VIP }
        break
    } // end switch (entrantType)
    
    if filteredArray.count > 0 {
        return (filteredArray[0] as! Guest)
    }
    return nil
    
} // end getEntrant(Guest)

func getEntrant(entrantType: WorkerType) -> Worker? {
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

