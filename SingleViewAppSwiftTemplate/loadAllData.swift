//
//  loadAllData.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 11/10/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

/*
    There has not been a unit that added functionality to the appDelegate yet,
    but I am thinking that pre-loading data like I am doing below would be
    done there.  I considered doing the load at the point of the first request
    for an entrant record (a call to populateFormWithRandomPerson()) or, later
    a call to canAccess(), but I would not design that way for a production app,
    since any of the problems that might cause a fail to pull the data at all
    should occur early.
*/

func loadAllData() -> Void {
    
do {
    rides = try loadRides(inputFile: "Rides", fileType: "plist") as! [Ride]
} catch let error {
    print(error)
}

do {
    vendors = try loadVendors(inputFile: "Vendors", fileType: "plist") as! [Vendor]
} catch let error {
    print(error)
}

do {
    nonpublics = try loadNonPublics(inputFile: "NonPublics", fileType: "plist") as! [NonPublic]
} catch let error {
    print(error)
}

do {
    workers = try loadWorkers(inputFile: "Workers", fileType: "plist") // includes contractors
} catch let error {
    print(error)
}

do {
    guests = try loadGuests(inputFile: "Guests", fileType: "plist")
} catch let error {
    print(error)
}

do {
    vendorFolks = try loadVendorStaff(inputFile: "VendorStaff", fileType: "plist")
} catch let error {
    print(error)
}
}
