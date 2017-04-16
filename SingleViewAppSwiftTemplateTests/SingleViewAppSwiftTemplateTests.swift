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
    
    override func setUp() {
        super.setUp()
        
        // create one of each needed object:
        vendorGate = Vendor(gateID: 1, gateType: GateType.FoodVendor, gateName: "Nathan's Hot Dogs")
        
        nonpublicGate = NonPublic(gateID: 1, gateType: .RideControl, gateName: "Whirlygig ride control")
        
        ride = Ride(gateID: 1, gateType: GateType.Amusement, gateName: "Whirlygig", ageRestricted: true)
        
        restrictedRide = Ride(gateID: 1, gateType: GateType.Amusement, gateName: "Whirlygig", ageRestricted: true)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: "1953-12-18")!
        anyWorker = Worker(entrantID: 1000, workerType: .HourlyFoodServices, firstName: "Roger", lastName: "Rohweder", streetAddress: "1205 Goldenview Ct", city: "Durham", state: "NC", zipCode: "27713", socialSecurityNumber: "329-50-6903", dateOfBirth: date)
        
        anyGuest = Guest(entrantID: 1, guestType: .Classic)
    }
    
    override func tearDown() {
        // swift will handle dealloc of objects.
        super.tearDown()
    }
    
    func testWorkerAccess () {
        
        // Test ride access with one worker (all workers can access rides):
        ride.gateType = .Amusement
        ride.gateName = "Whirlygig"
        anyWorker.workerType = .HourlyFoodServices
        XCTAssert(accessPermitted(requestor: anyWorker, gate: ride) == true)
        
        // Test NonPublic Area access with a worker who should have access and one who shouldn't (workers have different access rights):
        anyWorker.workerType = .HourlyFoodServices
        // using initial values of gateType: .RideControl, gateName: "Whirlygig ride control"
        XCTAssert(accessPermitted(requestor: anyWorker, gate: nonpublicGate) == false)
        
        anyWorker.workerType = .HourlyRideServices
        XCTAssert(accessPermitted(requestor: anyWorker, gate: nonpublicGate) == true)
        
    }
    
    func testGuestAccess () {
  
        
        // confirm that Guests have Amusement (ride) Area access (all guests can access all rides, with one exception (below)
        anyGuest.guestType = .Classic
        XCTAssert(accessPermitted(requestor: anyGuest, gate: ride) == true)

        // test the one exception: Child cannot ride on ageRestricted rides
        anyGuest.guestType = .FreeChild
        ride.gateType = .Amusement
        ride.ageRestricted = true
        XCTAssert(accessPermitted(requestor: anyGuest, gate: ride) == false)
        
        // confirm that Guests do not have NonPublic Area access
        XCTAssert(accessPermitted(requestor: anyGuest, gate: nonpublicGate) == false)
        
 /*
        anyGuest.guestType = .VIP
        XCTAssert(accessPermitted(requestor: anyGuest, gate: gate .Amusement) == true)
        XCTAssert(accessPermitted(requestor: anyGuest, gate: gate .Kitchen) == false)
        XCTAssert(accessPermitted(requestor: anyGuest, gate: gate .RideControl) == false)
        XCTAssert(accessPermitted(requestor: anyGuest, gate: gate .Maintenance) == false)
        XCTAssert(accessPermitted(requestor: anyGuest, gate: gate .Office) == false)
        
        anyGuest.guestType = .FreeChild
        XCTAssert(accessPermitted(requestor: anyGuest, gate: gate .Amusement) == true)
        XCTAssert(accessPermitted(requestor: anyGuest, gate: gate .Kitchen) == false)
        XCTAssert(accessPermitted(requestor: anyGuest, gate: gate .RideControl) == false)
        XCTAssert(accessPermitted(requestor: anyGuest, gate: gate .Maintenance) == false)
        XCTAssert(accessPermitted(requestor: anyGuest, gate: gate .Office) == false)
 */
    }
    
    
    func testDiscount() {

        // There typically wouldn't be different discounts per gate, only per product.
        // it maybe makes sense for an entrant to get X% for ANY food, Y% for ANY merchandise.
        // so I can skip the gate layer...

        anyGuest.guestType = .Classic
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Food) == 0)
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Merchandise) == 0)
        
        anyGuest.guestType = .VIP
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Food) == 10)
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Merchandise) == 20)
        
        anyGuest.guestType = .FreeChild
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Food) == 0)
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Merchandise) == 0)

        anyWorker.workerType = .HourlyFoodServices
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Food) == 15)
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Merchandise) == 25)
        
        anyWorker.workerType = .HourlyRideServices
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Food) == 15)
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Merchandise) == 25)
        
        anyWorker.workerType = .HourlyMaintenance
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Food) == 15)
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Merchandise) == 25)
        
        anyWorker.workerType = .Manager
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Food) == 25)
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Merchandise) == 25)

    }
    
    func testSkipPrivilege() {
        anyGuest.guestType = .Classic
        XCTAssert(canSkipLine(requestor: anyGuest, gateType: .Amusement) == false)
        
        anyGuest.guestType = .VIP
        XCTAssert(canSkipLine(requestor: anyGuest, gateType: .Amusement) == true)
        
        anyGuest.guestType = .FreeChild
        XCTAssert(canSkipLine(requestor: anyGuest, gateType: .Amusement) == false)

        anyWorker.workerType = .HourlyFoodServices
        XCTAssert(canSkipLine(requestor: anyWorker, gateType: .Amusement) == false)
        
        anyWorker.workerType = .HourlyRideServices
        XCTAssert(canSkipLine(requestor: anyWorker, gateType: .Amusement) == false)
        
        anyWorker.workerType = .HourlyMaintenance
        XCTAssert(canSkipLine(requestor: anyWorker, gateType: .Amusement) == false)
        
        anyWorker.workerType = .Manager
        XCTAssert(canSkipLine(requestor: anyWorker, gateType: .Amusement) == false)
        
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
