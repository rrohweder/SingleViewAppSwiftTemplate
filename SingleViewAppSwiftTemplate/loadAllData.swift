//
//  loadAllData.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 11/10/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

func loadAllData() -> Void {

let rules = RulesImporter()
do {
    try rules.loadRules()
} catch let error {
    print(error)
}

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
