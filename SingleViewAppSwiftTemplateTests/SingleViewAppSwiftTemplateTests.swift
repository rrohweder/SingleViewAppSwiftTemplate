//
//  SingleViewAppSwiftTemplateTests.swift
//  SingleViewAppSwiftTemplateTests
//
//  Created by Treehouse on 12/8/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import XCTest
@testable import SingleViewAppSwiftTemplate

class SingleViewAppSwiftTemplateTests: XCTestCase {

/*
    var vendorGate: Vendor!
    var nonpublicGate: NonPublic!
    var restrictedRide:Ride!
 */
    let dateFormatter = DateFormatter()
    var rules:RulesImporter!
    var accessAndBenefits: PermissionsAndBenefits!
    
    var anyWorker:Workers!
    var anyGuest:Guests!
    
    
    var rideNotRestricted:Ride!
    var rideRestricted:Ride!
    var areaRideControl:Gate!
    var areaAmusement:Gate!
    var areaKitchen:Gate!
    var areaMaintenance:Gate!
    var areaOffice:Gate!

    override func setUp() {
        super.setUp()
        
        let rules = RulesImporter()
        do {
            try rules.loadRules()
        } catch let error {
            print(error)
        }
        accessAndBenefits = PermissionsAndBenefits()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        rideNotRestricted = Ride(gateID: 1, gateType: .rideRides, gateName: "Not Age Restricted Ride", ageRestricted: false)
        rideRestricted = Ride(gateID: 1, gateType: .rideRides, gateName: "Age Restricted Ride", ageRestricted: true)
        
        areaAmusement = Gate(gateID: 1, gateType: .amusement, gateName: "Amusement Areas")
        areaRideControl = Gate(gateID: 1, gateType: .rideControl, gateName: "Ride Control Areas")
        
        areaKitchen = Gate(gateID: 1, gateType: .kitchen, gateName: "Kitchen Areas")
        areaMaintenance  = Gate(gateID: 1, gateType: .maintenance, gateName: "Maintenance Areas")
        areaOffice = Gate(gateID: 1, gateType: .office, gateName: "Office Areas")
        

    }
    
    override func tearDown() {
        // swift will handle dealloc of objects.
        super.tearDown()
    }
    
    // test access for all guests, all gates
    func testGuestAccess () {
        
        // Test access to all gates with Classic guest
        anyGuest = Guests(entrantID: 2, guestType: .classic)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: rideNotRestricted) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: rideRestricted) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaAmusement) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaRideControl) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaKitchen) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaMaintenance) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaOffice) == false)
        
        // Test access to all gates with VIP guest
        anyGuest = Guests(entrantID: 2, guestType: .vIP)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: rideNotRestricted) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: rideRestricted) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaAmusement) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaRideControl) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaKitchen) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaMaintenance) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaOffice) == false)
        
        // Test access to all gates with child
        anyGuest = FreeChildGuests(entrantID: 2, guestType: .freeChild, dateOfBirth: dateFormatter.date(from: "12/18/2014")!)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: rideNotRestricted) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: rideRestricted) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaAmusement) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaRideControl) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaKitchen) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaMaintenance) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaOffice) == false)
        
        // Test access to all gates with Season guest
        anyGuest = SeasonPassGuests(entrantID: 2, guestType: .season, firstName: "Season", lastName: "Guest", dateOfBirth: dateFormatter.date(from: "12/18/1953")!, streetAddress: "123 Anywhere", city: "Anytown", state: "NC", zipCode: "27713")
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: rideNotRestricted) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: rideRestricted) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaAmusement) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaRideControl) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaKitchen) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaMaintenance) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaOffice) == false)
        
        // Test access to all gates with Senior guest
        anyGuest = SeniorGuests(entrantID: 2, guestType: .senior, firstName: "Season", lastName: "Guest", dateOfBirth: dateFormatter.date(from: "12/18/1953")!)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: rideNotRestricted) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: rideRestricted) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaAmusement) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaRideControl) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaKitchen) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaMaintenance) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyGuest, gate: areaOffice) == false)
    }
    
    func testGuestDiscounts () {
        
        anyGuest = Guests(entrantID: 2, guestType: .classic)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyGuest, product: .food) == 0)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyGuest, product: .merchandise) == 0)
        
        anyGuest = Guests(entrantID: 2, guestType: .vIP)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyGuest, product: .food) == 10)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyGuest, product: .merchandise) == 20)

        anyGuest = FreeChildGuests(entrantID: 2, guestType: .freeChild, dateOfBirth: dateFormatter.date(from: "12/18/2014")!)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyGuest, product: .food) == 0)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyGuest, product: .merchandise) == 0)
        
        anyGuest = SeasonPassGuests(entrantID: 2, guestType: .season, firstName: "Season", lastName: "Guest", dateOfBirth: dateFormatter.date(from: "12/18/1953")!, streetAddress: "123 Anywhere", city: "Anytown", state: "NC", zipCode: "27713")
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyGuest, product: .food) == 10)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyGuest, product: .merchandise) == 20)

        anyGuest = SeniorGuests(entrantID: 2, guestType: .senior, firstName: "Season", lastName: "Guest", dateOfBirth: dateFormatter.date(from: "12/18/1953")!)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyGuest, product: .food) == 10)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyGuest, product: .merchandise) == 10)
    }
    
    func testGuestSkipLine () {
        
        anyGuest = Guests(entrantID: 2, guestType: .classic)
        XCTAssert(accessAndBenefits.canSkipLine(requestor: anyGuest, gateType: rideNotRestricted.gateType) == false)

        anyGuest = Guests(entrantID: 2, guestType: .vIP)
        XCTAssert(accessAndBenefits.canSkipLine(requestor: anyGuest, gateType: rideNotRestricted.gateType) == true)
        
        anyGuest = SeasonPassGuests(entrantID: 2, guestType: .season, firstName: "Season", lastName: "Guest", dateOfBirth: dateFormatter.date(from: "12/18/1953")!, streetAddress: "123 Anywhere", city: "Anytown", state: "NC", zipCode: "27713")
        XCTAssert(accessAndBenefits.canSkipLine(requestor: anyGuest, gateType: rideNotRestricted.gateType) == true)
     
        anyGuest = SeniorGuests(entrantID: 2, guestType: .senior, firstName: "Season", lastName: "Guest", dateOfBirth: dateFormatter.date(from: "12/18/1953")!)
        XCTAssert(accessAndBenefits.canSkipLine(requestor: anyGuest, gateType: rideNotRestricted.gateType) == true)
    }

    // test access for all workers, all gates
    func testWorkerAccess () {

        // Test access to all gates with Food Services worker
        anyWorker = Workers(entrantID: 1, workerType: .hourlyFoodServices, firstName: "FoodServices", lastName: "Worker", streetAddress: "123 Anywhere", city: "Anytown", state: "NC", zipCode: "27713", socialSecurityNumber: "123-45-6789", dateOfBirth: dateFormatter.date(from: "12/18/1953")!)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: rideNotRestricted) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: rideRestricted) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaAmusement) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaRideControl) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaKitchen) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaMaintenance) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaOffice) == false)
        // test for appropriate discounts
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyWorker, product: .food) == 15)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyWorker, product: .merchandise) == 25)


        // Test access to all gates with Ride Services worker
        anyWorker = Workers(entrantID: 1, workerType: .hourlyRideServices, firstName: "Ride Services", lastName: "Worker", streetAddress: "123 Anywhere", city: "Anytown", state: "NC", zipCode: "27713", socialSecurityNumber: "123-45-6789", dateOfBirth: dateFormatter.date(from: "12/18/1953")!)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: rideNotRestricted) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: rideRestricted) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaAmusement) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaRideControl) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaKitchen) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaMaintenance) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaOffice) == false)
        
        // Test access to all gates with Maintenance worker
        anyWorker = Workers(entrantID: 1, workerType: .hourlyMaintenance, firstName: "Maintenance", lastName: "Worker", streetAddress: "123 Anywhere", city: "Anytown", state: "NC", zipCode: "27713", socialSecurityNumber: "123-45-6789", dateOfBirth: dateFormatter.date(from: "12/18/1953")!)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: rideNotRestricted) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: rideRestricted) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaAmusement) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaRideControl) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaKitchen) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaMaintenance) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaOffice) == false)

        // Test access to all gates with Manager
        anyWorker = Workers(entrantID: 1, workerType: .manager, firstName: "Manager", lastName: "Worker", streetAddress: "123 Anywhere", city: "Anytown", state: "NC", zipCode: "27713", socialSecurityNumber: "123-45-6789", dateOfBirth: dateFormatter.date(from: "12/18/1953")!)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: rideNotRestricted) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: rideRestricted) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaAmusement) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaRideControl) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaKitchen) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaMaintenance) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaOffice) == true)
    }
    
    func testWorkerDiscount() {
        
        anyWorker = Workers(entrantID: 1, workerType: .hourlyFoodServices, firstName: "FoodServices", lastName: "Worker", streetAddress: "123 Anywhere", city: "Anytown", state: "NC", zipCode: "27713", socialSecurityNumber: "123-45-6789", dateOfBirth: dateFormatter.date(from: "12/18/1953")!)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyWorker, product: .food) == 15)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyWorker, product: .merchandise) == 25)

        anyWorker = Workers(entrantID: 1, workerType: .manager, firstName: "Manager", lastName: "Worker", streetAddress: "123 Anywhere", city: "Anytown", state: "NC", zipCode: "27713", socialSecurityNumber: "123-45-6789", dateOfBirth: dateFormatter.date(from: "12/18/1953")!)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyWorker, product: .food) == 25)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyWorker, product: .merchandise) == 25)

    }
    
    func testWorkerSkipLine() {
        anyWorker = Workers(entrantID: 1, workerType: .hourlyFoodServices, firstName: "FoodServices", lastName: "Worker", streetAddress: "123 Anywhere", city: "Anytown", state: "NC", zipCode: "27713", socialSecurityNumber: "123-45-6789", dateOfBirth: dateFormatter.date(from: "12/18/1953")!)
        XCTAssert(accessAndBenefits.canSkipLine(requestor: anyWorker, gateType: rideNotRestricted.gateType) == false)
        // and none of them do.
    }

    // Test access for the VendorStaff of all 4 companies
    func testVendorStaffAccess () {
        
       // Vendor Staff, FedEx
        anyWorker = VendorStaff(entrantID: 2, workerType: .vendorStaff, firstName: "Vendor Staff (FedEx)", lastName: "Worker", dateOfBirth: dateFormatter.date(from: "12/18/1953")!, companyName: "FedEx", dateOfLastVisit: dateFormatter.date(from: "11/18/2017")!)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: rideNotRestricted) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: rideRestricted) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaAmusement) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaRideControl) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaKitchen) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaMaintenance) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaOffice) == false)
        
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyWorker, product: .food) == 0)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyWorker, product: .merchandise) == 0)

        // Vendor Staff, Orkin
        anyWorker = VendorStaff(entrantID: 2, workerType: .vendorStaff, firstName: "Vendor Staff (Orkin)", lastName: "Worker", dateOfBirth: dateFormatter.date(from: "12/18/1953")!, companyName: "Orkin", dateOfLastVisit: dateFormatter.date(from: "11/18/2017")!)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: rideNotRestricted) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: rideRestricted) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaAmusement) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaRideControl) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaKitchen) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaMaintenance) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaOffice) == false)
    }
    
    func testVendorStaffDiscounts() {
        // should be none
        anyWorker = VendorStaff(entrantID: 2, workerType: .vendorStaff, firstName: "Vendor Staff (Orkin)", lastName: "Worker", dateOfBirth: dateFormatter.date(from: "12/18/1953")!, companyName: "Orkin", dateOfLastVisit: dateFormatter.date(from: "11/18/2017")!)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyWorker, product: .food) == 0)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyWorker, product: .merchandise) == 0)
    }

    func testContractorAccess() {
        
        anyWorker = Contractors(entrantID: 2, workerType: .contract, firstName: "Project1001", lastName: "Contractor", streetAddress: "123 Main St", city: "Dublin", state: "OH", zipCode: "544445", socialSecurityNumber: "987-65-4321", dateOfBirth: dateFormatter.date(from: "06/05/1982")!, projectNumber: 1001)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: rideRestricted) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaAmusement) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaRideControl) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaKitchen) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaMaintenance) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaOffice) == false)
        
        anyWorker = Contractors(entrantID: 2, workerType: .contract, firstName: "Project1002", lastName: "Contractor", streetAddress: "123 Main St", city: "Dublin", state: "OH", zipCode: "544445", socialSecurityNumber: "987-65-4321", dateOfBirth: dateFormatter.date(from: "06/05/1982")!, projectNumber: 1002)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: rideRestricted) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaAmusement) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaRideControl) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaKitchen) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaMaintenance) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaOffice) == false)
        
        anyWorker = Contractors(entrantID: 2, workerType: .contract, firstName: "Project1003", lastName: "Contractor", streetAddress: "123 Main St", city: "Dublin", state: "OH", zipCode: "544445", socialSecurityNumber: "987-65-4321", dateOfBirth: dateFormatter.date(from: "06/05/1982")!, projectNumber: 1003)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: rideRestricted) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaAmusement) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaRideControl) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaKitchen) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaMaintenance) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaOffice) == true)
        
        anyWorker = Contractors(entrantID: 2, workerType: .contract, firstName: "Project2001", lastName: "Contractor", streetAddress: "123 Main St", city: "Dublin", state: "OH", zipCode: "544445", socialSecurityNumber: "987-65-4321", dateOfBirth: dateFormatter.date(from: "06/05/1982")!, projectNumber: 2001)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: rideRestricted) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaAmusement) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaRideControl) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaKitchen) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaMaintenance) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaOffice) == true)
        
        anyWorker = Contractors(entrantID: 2, workerType: .contract, firstName: "Project2002", lastName: "Contractor", streetAddress: "123 Main St", city: "Dublin", state: "OH", zipCode: "544445", socialSecurityNumber: "987-65-4321", dateOfBirth: dateFormatter.date(from: "06/05/1982")!, projectNumber: 2002)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: rideRestricted) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaAmusement) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaRideControl) == false)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaKitchen) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaMaintenance) == true)
        XCTAssert(accessAndBenefits.accessPermitted(requestor: anyWorker, gate: areaOffice) == false)
    }
    
    func testContractorDiscounts() {
        // should be none
        anyWorker = Contractors(entrantID: 2, workerType: .contract, firstName: "Project2002", lastName: "Contractor", streetAddress: "321 East St", city: "Denver", state: "CO", zipCode: "76233", socialSecurityNumber: "876-55-3456", dateOfBirth: dateFormatter.date(from: "12/18/1953")!, projectNumber: 2002)
        
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyWorker, product: .food) == 0)
        XCTAssert(accessAndBenefits.discountAvailable(requestor: anyWorker, product: .merchandise) == 0)

    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
