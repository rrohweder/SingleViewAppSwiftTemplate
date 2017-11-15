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
    
    var gate:Gate!
    var vendorGate: Vendor!
    var nonpublicGate: NonPublic!
    var ride:Ride!
    var restrictedRide:Ride!
    var anyWorker:Worker!
    var anyGuest:Guest!
    var rules:RulesImporter!
    
    override func setUp() {
        super.setUp()
        
        // create one of each needed object:
        vendorGate = Vendors(gateID: 1, gateType: GateType.foodVendor, gateName: "Nathan's Hot Dogs")
        nonpublicGate = NonPublic(gateID: 1, gateType: .RideControl, gateName: "Whirlygig ride control")
        ride = Ride(gateID: 1, gateType: GateType.RideRides, gateName: "Whirlygig", ageRestricted: true)
        restrictedRide = Rides(gateID: 1, gateType: GateType.RideRides, gateName: "Whirlygig", ageRestricted: true)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: "1953-12-18")!
        anyWorker = Workers(entrantID: 1000, workerType: .HourlyFoodServices, firstName: "Roger", lastName: "Rohweder", streetAddress: "1205 Goldenview Ct", city: "Durham", state: "NC", zipCode: "27713", socialSecurityNumber: "329-50-6903", dateOfBirth: date)
        
        anyGuest = Guest(entrantID: 1, guestType: .Classic)
        
        let rules = RulesImporter()
        do {
            try rules.loadRules()
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        // swift will handle dealloc of objects.
        super.tearDown()
    }
    
    func testWorkerAccess () {
        
        // Test ride access with one worker (all workers can access rides):
        ride.gateType = .RideRides
        ride.gateName = "Whirlygig"
        anyWorker.workerType = .hourlyFoodServices
        XCTAssert(accessPermitted(requestor: anyWorker, gate: ride) == true)
        
        // Test NonPublic Area access with a worker who should have access and one who shouldn't (workers have different access rights):
        anyWorker.workerType = .hourlyFoodServices
        // using initial values of gateType: .RideControl, gateName: "Whirlygig ride control"
        XCTAssert(accessPermitted(requestor: anyWorker, gate: nonpublicGate) == false)
        
        anyWorker.workerType = .hourlyRideServices
        XCTAssert(accessPermitted(requestor: anyWorker, gate: nonpublicGate) == true)
        
    }
    
    func testGuestAccess () {
  
        // confirm that Guests have RideRides (ride) Area access (all guests can access all rides, with one exception (below)
        XCTAssert(canAccess(guestType: .classic, gateType: .rideRides) == true)  // it worked!!!

        // test the one exception: Child cannot ride on ageRestricted rides
        anyGuest.guestType = .freeChild
        ride.gateType = .rideRides
        ride.ageRestricted = true
        XCTAssert(accessPermitted(requestor: anyGuest, gate: ride) == false)

        // confirm that Guests do not have NonPublic Area access
        XCTAssert(accessPermitted(requestor: anyGuest, gate: nonpublicGate) == false)
        
    }
    
    
    func testDiscount() {

        // There typically wouldn't be different discounts per gate, only per product.
        // it maybe makes sense for an entrant to get X% for ANY food, Y% for ANY merchandise.
        // so I can skip the gate layer...

        anyGuest.guestType = .classic
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Food) == 0)
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Merchandise) == 0)
        
        anyGuest.guestType = .vIP
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Food) == 10)
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Merchandise) == 20)
        
        anyGuest.guestType = .freeChild
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Food) == 0)
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Merchandise) == 0)

        anyWorker.workerType = .hourlyFoodServices
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Food) == 15)
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Merchandise) == 25)
        
        anyWorker.workerType = .hourlyRideServices
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Food) == 15)
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Merchandise) == 25)
        
        anyWorker.workerType = .hourlyMaintenance
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Food) == 15)
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Merchandise) == 25)
        
        anyWorker.workerType = .manager
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Food) == 25)
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Merchandise) == 25)

    }
    
    func testSkipPrivilege() {
        anyGuest.guestType = .classic
        XCTAssert(canSkipLine(requestor: anyGuest, gateType: .RideRides) == false)
        
        anyGuest.guestType = .vIP
        XCTAssert(canSkipLine(requestor: anyGuest, gateType: .RideRides) == true)
        
        anyGuest.guestType = .freeChild
        XCTAssert(canSkipLine(requestor: anyGuest, gateType: .RideRides) == false)

        anyWorker.workerType = .hourlyFoodServices
        XCTAssert(canSkipLine(requestor: anyWorker, gateType: .RideRides) == false)
        
        anyWorker.workerType = .hourlyRideServices
        XCTAssert(canSkipLine(requestor: anyWorker, gateType: .RideRides) == false)
        
        anyWorker.workerType = .hourlyMaintenance
        XCTAssert(canSkipLine(requestor: anyWorker, gateType: .RideRides) == false)
        
        anyWorker.workerType = .manager
        XCTAssert(canSkipLine(requestor: anyWorker, gateType: .RideRides) == false)
        
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
